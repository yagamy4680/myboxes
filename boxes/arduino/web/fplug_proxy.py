#!/usr/bin/env python

import signal
import sys
from colorama import Fore, Back, Style
import time
from datetime import datetime, timedelta
import json
import requests
import pyfplug

def signal_handler(signal, frame):
    print("")
    print("You pressed Ctrl + C, gracefully exit the program...")
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)

def getTimePrefix():
    now = time.time()
    current = datetime.fromtimestamp(now)
    return current.strftime("%Y/%m/%d-%H:%M:%S")

def printDeviceMessage(type, line):
    message = Fore.CYAN + getTimePrefix()
    message += (Fore.WHITE + ' [DEVICE]: ')
    if "I" == tokens[1]:
        message += (Fore.YELLOW + line)
    elif "D" == tokens[1]:
        message += (Fore.MAGENTA + line)
    else:
        message += (Fore.WHITE + line)
    message += Fore.RESET
    print message

def printHostMessage(line):
    message = Fore.CYAN + getTimePrefix()
    message += (Fore.WHITE + ' [HOST  ]: ')
    message += line
    print message

class Object:
    def to_json(self):
        return json.dumps(self, default=lambda o: o.__dict__, sort_keys=True, separators=(',',':'), indent=None)

def postSensorData(retrievalTime, name, data):
    printHostMessage("%s: %f" % (name, data))
    sensorData = Object()
    sensorData.name = name
    sensorData.last = data
    sensorData.max = data
    sensorData.min = data
    sensorData.mean = data
    sensorData.count = 1
    sensorData.lastMillis = retrievalTime.strftime("+0000 %Y/%m/%d %H:%M:%S.%f")
    jsonText = sensorData.to_json()
    printHostMessage(jsonText)
    url = "http://localhost:4000/api/data/%s" % sensorData.name
    # url = "http://192.168.7.105:4000/api/data/%s" % sensorData.name
    headers = {'content-type': 'application/json'}
    response = requests.post(url, jsonText, headers=headers)

dev = pyfplug.FPlugDevice('/dev/rfcomm0')

while True:
    temperature = dev.get_temperature()
    postSensorData(datetime.utcnow(), "fplug.temperature", temperature)

    illuminance = dev.get_illuminance()
    postSensorData(datetime.utcnow(), "fplug.illuminance", illuminance)

    humidity = dev.get_humidity()
    postSensorData(datetime.utcnow(), "fplug.humidity", humidity)

    power = dev.get_power_realtime()
    postSensorData(datetime.utcnow(), "fplug.power", power)

    time.sleep(1)
