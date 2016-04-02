window.VideoLibrary =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> 
  	new VideoLibrary.Routers.Comments()
  	Backbone.history.start()

$(document).ready ->
  VideoLibrary.initialize()
