p = (x...) -> console.log x...

getParam = (name) ->
  re = new RegExp "#{name}=(.+?)(&|$)"
  result = re.exec location.search
  if result then decodeURI result[1] else null
  
Template.iframe.helpers
  technology: -> Session.get 'technology'
  role: -> Session.get 'role'
  
Template.iframe.events
  'click .webrtc':  -> Session.set 'technology', 'webrtc'
  'click .flash':   -> Session.set 'technology', 'flash'
  'click .coach':   -> Session.set 'role', 'coach'
  'click .user':    -> Session.set 'role', 'user'


Meteor.startup ->
  params = ['technology', 'role']
  Session.set param, getParam param for param in params
  p param, getParam param for param in params
