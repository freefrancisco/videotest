## Extensions to meteor

## Use App instead of meteor, and add new global behavior here
class App extends Meteor
  # extend app with helper functions
  @helpers: (helperFunctions) ->  
    _.extend @, helperFunctions
    
  @selector: (selector) -> #normalize selector, can be id by itself or mongo expression
    if _.isObject selector then selector else {_id: selector}
    
  @isRole: (userSelector, role) -> 
    user = Meteor.users.findOne @selector userSelector
    return false unless user?.role
    !!~user.role.indexOf role
    
  @isCoach: (selector) -> @isRole selector, "coach"
  @isAdmin: (selector) -> @isRole selector, "admin"
      
  @username: -> @user()?.username
  @currentIsCoach: -> @user()?.role? and !!~@user().role.indexOf "coach"
  @currentIsAdmin: -> @user()?.role? and !!~@user().role.indexOf "admin"
  
  
## Use this to add behavior to Collections created by us with App.Collection
# safer to do it here than extending Meteor.Collection below
class App.Collection extends Meteor.Collection
  findOrCreate: (selector) ->
    if selector._id
      found = @findOne selector._id
    else 
      found = @findOne selector
    @insert selector unless found


# Use this to add behavior to ALL meteor collections, 
# including already existing collections that we didn't create, 
# such as Meteor.users.  Safer to use App.Collection than this.  
_.extend Meteor.Collection::, 
  # extend a collection wih helper functions
  helpers: (helperFunctions) ->  
    _.extend @, helperFunctions
  #remove all elements from collection
  clear: ->     
    @remove {}

# publish App explicitly to make it compatible with new meteor
@App = App
