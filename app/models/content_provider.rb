class ContentProvider < ActiveRecord::Base
	has_many :shows

	def get_resp(url=self.url, ua="Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.87 Safari/537.36")
		options = {
		verify:false,
		follow_redirects: true,
		headers:{"User-Agent" => ua}
		}
		puts "before!!!!"
		result = HTTParty.get(url,options)
		puts "after!!!"
		result
  	end

  	# generic method to extract a content providers title and description using their URL
  	def set_title_and_description
  		resp = get_resp(self.url)
  		self.title = resp.match(/<title>(.+)<\/title>/)[1]
  		self.description = resp.match(/<meta name="description" content="([^\"]*)/)[1]
  		self.save!
  	end

  	# will grab links to shows and update/create a model for each show
  	def get_all_index_links_to_each_vland_show
  		# index link for shows
  		resp = get_resp(self.url)
  		show_index_link = self.url + resp.match(/"\/([^"]*\/shows)/)[1]
  		#should probbly store this on something but yolo
  		resp_shows = get_resp(show_index_link)
  		# create show urls by link
  		resp_shows.scan(/href="([^"]*show\/[^"]*)/).uniq.each do |show_url|
  			Show.find_or_create_by(url:show_url)
  		end
  	end

  	# will interate over each show and for each show grab all links that
  	# are to a free episode that does not require a login to watch on the site
  	def get_all_free_episode_links_for_each_show_on_vland
  		Show.all.each do |show|

  		end
  	end

  	# TODOL: nail down logic/heuristic to tweet about newly added free video content.
  	# crobjob will be needed if this application actually ever runs persistently.
  	def tweet_link_for_new_free_episode_vland
  		# TODO
  	end
end
