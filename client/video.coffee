p = (x...) -> console.log x...
SESSION = "1_MX4xMTI3fn5UdWUgSnVuIDA0IDAyOjU5OjAzIFBEVCAyMDEzfjAuNDYyMTA0OH4"
TOKEN = "T1==cGFydG5lcl9pZD0xMTI3JnNpZz0yZjg1MGFhMGM0Y2VlOGM5YmQ0ZGU0Mjk2MzJiNTVjMTEyYjgxNzNlOnNlc3Npb25faWQ9MV9NWDR4TVRJM2ZuNVVkV1VnU25WdUlEQTBJREF5T2pVNU9qQXpJRkJFVkNBeU1ERXpmakF1TkRZeU1UQTBPSDQmY3JlYXRlX3RpbWU9MTM3MDMzOTk0MyZub25jZT0zNzYwOTAmcm9sZT1wdWJsaXNoZXI="

videoRunning = false
@videoStuff = =>
  return if videoRunning
  videoRunning = true
  p "in video stuff, TB:", TB
  TB.addEventListener "exception", exceptionHandler
  session = TB.initSession SESSION
  p "session:", session
  session.addEventListener "sessionConnected", sessionConnectedHandler
  session.addEventListener "streamCreated", streamCreatedHandler
  session.connect 1127, TOKEN
  p "done connecting session", session
  @session = session
  
  sessionConnectedHandler = (event) ->
    p "calling session connected handler"
    subscribeToStreams event.streams
    session.publish()
    
  streamCreatedHandler = (event) ->
    p "called stream created handler"
    subscribeToStreams event.streams
    
  subscribeToStreams = (streams) ->
    p "called subscribe to streams, session:", session
    for s in streams
      unless s.connection.connectionId is session.connection.connectionId
        session.subscribe s 
        
  exceptionHandler = (event) ->
    p "calling exception handler"
    alert event.message