class VideoLibrary.Routers.Comments extends Backbone.Router
  routes:
    '': 'index'

  index: ->
    view = new VideoLibrary.Views.CommentsIndex()
    $('#view_comments').html(view.render().el)