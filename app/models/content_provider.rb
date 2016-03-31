class ContentProvider < ActiveRecord::Base
	has_many :shows

	def get_resp(url, ua="Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.87 Safari/537.36")
		options = {
		verify:false,
		follow_redirects: true,
		headers:{"User-Agent" => ua}
		}
		result = HTTParty.get(url,options)
  	end

  	# generic method to extract a content providers title and description using their URL
  	def set_title_and_description
  		get_resp(self.url)
  		# TODO: extract title and description from response
  	end

  	# will grab links to shows and update/create a model for each show
  	def get_all_index_links_to_each_vland_show
  		# this is where the fun starts
  	end

  	# will interate over each show and for each show grab all links that
  	# are to a free episode that does not require a login to watch on the site
  	def get_all_free_episode_links_for_each_show_on_vland
  		# TODO
  	end

  	# TODOL: nail down logic/heuristic to tweet about newly added free video content.
  	# crobjob will be needed if this application actually ever runs persistently.
  	def tweet_link_for_new_free_episode_vland
  		# TODO
  	end
end
