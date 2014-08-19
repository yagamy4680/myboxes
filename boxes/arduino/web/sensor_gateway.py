#!/usr/bin/env python

from bottle import route, run, post, get, request, static_file

myData = {}

@route('/hello')
def hello():
    return "Hello World!\n"

@post('/api/data/<name>')
def updateData(name='hello'):
    jsonData = request.json
    print(jsonData)
    myData[name] = jsonData
    return "Got it!!\n"

@get('/api/data/<name>')
def updateData(name='hello'):
    jsonData = myData[name]
    print(jsonData)
    return jsonData

@route('/')
def serverRoot():
    return static_file('index.html', root='./www')

@route('/scripts/<filepath:path>')
def serverStaticScript(filepath):
    return static_file(filepath, root='./www')

run(host='0.0.0.0', port=4000, debug=True)
