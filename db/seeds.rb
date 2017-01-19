# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "seeding users"

emails = ["admin_user@delete_this_seed.com",
		"member_user@delete_this_seed.com"]
emails.each do |email|
	puts "created user: login:#{email} password:#{email.split("@").first + '123'}"
	u = User.new#(:email => "#{email}", :password => email.split("@").first << "123", :password_confirmation => email.split("@").first << "123")
	u.email = "#{email}"
	u.password = email.split("@").first + "123"
	u.password_confirmation = email.split("@").first + "123"
	u.save!
end

puts 'Adding roles to both users.'
User.find_by(email:"admin_user@delete_this_seed.com").add_role :admin
User.find_by(email:"member_user@delete_this_seed.com").add_role :member
# content provider 1
# code obfuscation provided by reverse!
a = "dnaleciv"
url = "https://www." + a.reverse + ".com/"
title = url.match(/\.+(.+)\.+/)[1]
c1=ContentProvider.create(title: title, url: url)
c1.save!

# time to httparty and possibly bring one of my favorite friends, nokogiri(she brought the mechanizer).
c1.set_title_and_description
c1.get_all_index_links_to_each_vland_show
c1.get_all_free_episode_links_for_each_show_on_vland

# aftrer intial seeds are run a cron job will be set-up to tweet links to any new free
# free content. New free content will be checked for once every x hours or x days.


# TODO: next two providers hopefully will be done through a public API so its easy mode.
# Maybe I will get to write content provider 1's private and/or public API's ;)

# content provider 2
# TODO
# content provider 3
# TODO