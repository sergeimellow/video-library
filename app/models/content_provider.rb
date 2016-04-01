class ContentProvider < ActiveRecord::Base
	has_many :shows

	def get_resp(url=self.url, ua="Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.87 Safari/537.36")
		options = {
		verify:false,
		follow_redirects: true,
		headers:{"User-Agent" => ua}
		}
		puts  "grabbing html of:#{url}"
		result = HTTParty.get(url,options)
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
  		# create shows by urls
  		resp_shows.scan(/href="([^"]*show\/[^"]*)/).uniq.each do |show_url|
  			show=Show.find_or_initialize_by(url: "https:" + show_url.to_s.gsub(/["\[\]]/,""))
  			if show.new_record?
  				show.content_provider_id = self.id
  				show.save!
  			end
  		end
  	end

  	# will iterate over each show and for each show or clip and grab all links that
  	# are to a free content that does not require a login to watch on the site
  	def get_all_free_episode_links_for_each_show_on_vland
  		Show.all.each do |show|
  			puts "getting epsides for #{show.url}"
  			# sometimes its nice to take a 2-3 sec nap
  			sleep(rand(2..3))
  			resp = get_resp(show.url)
  			# this is the point where I got tired of heavy lifting
  			html_result = Nokogiri::HTML.parse(resp.body)
  			html_result.css(".entry-card").each do |clip|
  				# skip episdes / clips that are not free to watch, may also one day limit it to just episodes.
  				next if clip.css(".unlockable").first.to_s.include? "icon-locked"
  				# grabs sub link to epsides or clip
  				episode_or_clip_url = clip.css(".cta").attr("href").to_s
  				#getting rid of a "/" at the start
  				episode_or_clip_url[0] = ""

  				# lets create some links pertaining to shows and clips from shows
  				ep = Episode.find_or_initialize_by(url: self.url + episode_or_clip_url)
  				if ep.new_record?
  					ep.show_id=show.id
  					#can do fancy stuff here like grab all show episode / clip fields 
  					ep.save!
  				end
  			end
  		end
  	end

  	# TODOL: nail down logic/heuristic to tweet about newly added free video content.
  	# crobjob will be needed if this application actually ever runs persistently.
  	def tweet_link_for_new_free_episode_vland
  		# TODO
  	end
end
