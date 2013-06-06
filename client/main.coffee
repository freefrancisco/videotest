jqvidrun = ->
  $ ->
    console.log "the jquery is done"
    videoStuff()
    
Template.iframe.helpers
  technology: -> Session.get 'technology'
  role: -> Session.get 'role'
  
Template.iframe.events
  'click .webrtc':  -> Session.set 'technology', 'webrtc'
  'click .flash':   -> Session.set 'technology', 'flash'
  'click .coach':   -> Session.set 'role', 'coach'
  'click .user':    -> Session.set 'role', 'user'

