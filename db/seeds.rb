# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

accounts= {
					'system@kiranatama.com' => 'System',
					'user@kiranatama.com' => 'User',
					'user1@kiranatama.com' => 'User',
					'user2@kiranatama.com' => 'User',
					'user3@kiranatama.com' => 'User',
					'team@kiranatama.com' => 'Team',
					'stock@kiranatama.com' => 'Stock'
					}

Account.all.each do |a|
	a.destroy
end

accounts.each do |k, v|
	acc= Account.new(email: k, password: k, password_confirmation: k, type: v)
	acc.skip_confirmation! if v=='User'
	puts k if acc.save!
	next if v=='System'
	10.times do
		acc.top_up(rand(1000))
	end
end