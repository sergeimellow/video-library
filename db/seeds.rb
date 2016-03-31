# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "seeding users"

emails=["admin_user@delete_this_seed.com",
		"member_user@edlete_this_seed.com"]
emails.each do |email|
	puts "created user: login:#{email} password:#{email.split("@").first + '123'}"
	u = User.new#(:email => "#{email}", :password => email.split("@").first << "123", :password_confirmation => email.split("@").first << "123")
	u.email = "#{email}"
	u.password = email.split("@").first + "123"
	u.password_confirmation = email.split("@").first + "123"
	u.save!
end

puts 'Adding roles to both users.'
u=User.find_by(email:"admin_user@delete_this_seed.com").add_role :admin
u.save!
u=User.find_by(email:"member_user@delete_this_seed.com").add_role :member
u.save!
