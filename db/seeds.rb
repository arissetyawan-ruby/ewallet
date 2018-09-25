# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
System.delete_all
Stock.delete_all
Team.delete_all

System.create(name: 'System')
Stock.create(name: 'Stock')
Team.create(name: 'Team')

users= {
					'user@kiranatama.com' => 'User',
					'user1@kiranatama.com' => 'User',
					'user2@kiranatama.com' => 'User',
					'user3@kiranatama.com' => 'User'
					}

User.all.each do |a|
	a.destroy
end

users.each do |k, v|
	acc= User.new(email: k, password: k, password_confirmation: k)
	acc.skip_confirmation!
	puts k if acc.save!
end