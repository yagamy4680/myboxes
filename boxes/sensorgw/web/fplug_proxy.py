#!/usr/bin/env python

import signal
import sys
from colorama import Fore, Back, Style
import time
from datetime import datetime, timedelta
import json
import requests
import pyfplug
from optparse import OptionParser

def signal_handler(signal, frame):
    print("")
    print("You pressed Ctrl + C, gracefully exit the program...")
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)
options = None
args = None
fplug = None
url = None

def getTimePrefix():
    now = time.time()
    current = datetime.fromtimestamp(now)
    return current.strftime("%Y/%m/%d-%H:%M:%S")

def printDeviceMessage(line):
    message = Fore.CYAN + getTimePrefix()
    message += (Fore.WHITE + ' [DEVICE]: ')
    message += line
    message += Fore.RESET
    if options.verbose:
        print message

def printHostMessage(line):
    message = Fore.CYAN + getTimePrefix()
    message += (Fore.WHITE + ' [HOST  ]: ')
    message += line
    if options.verbose:
        print message

class Object:
    def to_json(self):
        return json.dumps(self, default=lambda o: o.__dict__, sort_keys=True, separators=(',',':'), indent=None)

def postSensorData(retrievalTime, name, data):
    if data == None:
        return
    printDeviceMessage("%s: %f" % (name, data))
    sensorData = Object()
    sensorData.name = name
    sensorData.last = data
    sensorData.max = data
    sensorData.min = data
    sensorData.mean = data
    sensorData.count = 1
    sensorData.lastMillis = retrievalTime.strftime("+0000 %Y/%m/%d %H:%M:%S.%f")
    jsonText = sensorData.to_json()
    # printHostMessage(jsonText)
    headers = {'content-type': 'application/json'}
    absoluteURL = "%s%s" % (url, sensorData.name)
    response = requests.post(absoluteURL, jsonText, headers=headers)

def queryTemperature():
    try:
      temperature = fplug.get_temperature()
      postSensorData(datetime.utcnow(), "fplug.temperature", temperature)
    except pyfplug.UnknownState as e:
      printHostMessage("error: %s" % e)

def queryIlluminance():
    try:
      illuminance = fplug.get_illuminance()
      postSensorData(datetime.utcnow(), "fplug.illuminance", illuminance)
    except pyfplug.UnknownState as e:
      printHostMessage("error: %s" % e)

def queryHumidity():
    try:
      humidity = fplug.get_humidity()
      postSensorData(datetime.utcnow(), "fplug.humidity", humidity)
    except pyfplug.UnknownState as e:
      printHostMessage("error: %s" % e)

def queryPower():
    try:
      power = fplug.get_power_realtime()
      postSensorData(datetime.utcnow(), "fplug.power", power)
    except pyfplug.UnknownState as e:
      printHostMessage("error: %s" % e)

parser = OptionParser() 
parser.add_option("-d", "--device", dest="device", action="store", type="string", default="/dev/rfcomm0", help="rfcomm device to read F-Plug data", metavar="DEVICE")
parser.add_option("-q", "--quiet", action="store_false", dest="verbose", default=True, help="don't print status messages to stdout")
parser.add_option("-p", "--port", type="int", dest="port", default=4000, help="port number for destination server")
parser.add_option("-s", "--server", type="string", dest="server", default="localhost", help="hostname for destination server")

(options, args) = parser.parse_args()
url = "http://%s:%d/api/data/" % (options.server, options.port)

if options.verbose:
    print("verbose = %s" % options.verbose)
    print("reading F-Plug data from %s" % options.device)
    print("url = %s" % url)

fplug = pyfplug.FPlugDevice(options.device)
count = 0

while True:
    now = datetime.utcnow()
    queryIlluminance()
    delta = datetime.utcnow() - now
    print("delta = %s" % delta)
    queryPower()
    queryIlluminance()
    #queryHumidity()
    queryIlluminance()
    #queryPower()
    queryIlluminance()
    #queryTemperature()
    # time.sleep(1)
    count = count + 1
    if count == 10:
      queryHumidity()
    if count == 20:
      queryTemperature()
      count = 0

