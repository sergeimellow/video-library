class VideoLibrary.Views.CommentsIndex extends Backbone.View

  template: JST['comments/index']

  render: ->
  	$(@el).html(@template())
  	@