Conversations.helpers
  updateVideoSession:  (conversationId, videoSessionId) ->
    Conversations.update _id: conversationId, 
      $set: videoSessionId: videoSessionId

Meteor.methods
  'videoSession': (convoID, syncCallFinishKey) ->
    convo = Conversations.findOne(convoID)
    console.log 'videoSession: starting for convo & scfk', convoID, syncCallFinishKey
    if convo.videoSessionId?
      syncServerCallReturn(syncCallFinishKey, convo.videoSessionId)
    else
      options = 'p2p.preference' : if convo.public then 'disabled' else 'enabled'
      OpenTok.create_session options, (videoSessionId) =>
        console.log 'videoSession: OpenTok.create_session complete - CREATED NEW', videoSessionId
        Fiber -> # this a callback so we're no longer in Meteor territory. must run all Meteor code in a Fiber, so start one here.
          Conversations.updateVideoSession convoID, videoSessionId
          syncServerCallReturn(syncCallFinishKey, videoSessionId)
        .run()
          
  # role can be subscriber, publisher, and moderator
  'videoToken': (userId, convoID, sessionID, role, syncCallFinishKey) ->
    tokenObj = VideoTokens.findOne userId: userId, conversationId: convoID
    token = OpenTok.generateToken
      connection_data: "#{userId}:#{convoID}"
      session_id: sessionID
      role: role
    if tokenObj
      VideoTokens.update userId: userId, conversationId: convoID,
        $set: token: token
      console.log 'videoToken: UPDATED TOKEN'
    else
      VideoTokens.insert userId: userId, conversationId: convoID, token: token
      console.log 'videoToken: CREATED NEW'
    syncServerCallReturn(syncCallFinishKey, token)
      
  'removeVideoToken': (userId, convoID) ->
    VideoTokens.remove userId: userId, conversationId: convoID
