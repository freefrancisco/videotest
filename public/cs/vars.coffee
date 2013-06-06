console.log "file was included"

apiKey = 1127
sessionID = "1_MX4xMTI3fn5UdWUgSnVuIDA0IDEyOjU2OjA2IFBEVCAyMDEzfjAuNDI5NjY4Mn4"
tokenID = "T1==cGFydG5lcl9pZD0xMTI3JnNpZz0yMjg1OTIwYTc0MzNlNTMxNjRlNDRmODZiYjUxOWFmMjYzOTFjNjJjOnNlc3Npb25faWQ9MV9NWDR4TVRJM2ZuNVVkV1VnU25WdUlEQTBJREV5T2pVMk9qQTJJRkJFVkNBeU1ERXpmakF1TkRJNU5qWTRNbjQmY3JlYXRlX3RpbWU9MTM3MDM3NTg2MSZub25jZT01MDQ4NSZyb2xlPXB1Ymxpc2hlcg=="


TB.addEventListener "exception", exceptionHandler

session = TB.initSession sessionID
session.addEventListener "sessionConnected", sessionConnectedHandler
session.addEventListener "streamCreated", streamCreatedHandler
session.connect apiKey, tokenID

sessionConnectedHandler = (event) ->
  subscribeToStreams event.streams
  session.publish()
  
streamCreatedHandler = (event) ->
  subscribeToStreams event.streams
  
subscribeToStreams = (streams) ->
  for stream in streams
    unless stream.connection.connectionId is session.connection.connectionId
      session.subscribe stream 
  
exceptionHandler = (event) ->
  alert event.message
  

@apiKey = apiKey
@sessionID = sessionID
@tokenID = tokenID

@session = session
@sessionConnectedHandler = sessionConnectedHandler
@streamCreatedHandler = streamCreatedHandler
@subscribeToStreams = subscribeToStreams
@exceptionHandler = exceptionHandler

console.log "the end", @