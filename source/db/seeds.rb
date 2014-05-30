require 'faker'

User.delete_all
Idea.delete_all
Vote.delete_all
Image.delete_all
Category.delete_all

30.times do
  User.create(first_name: Faker::Name.first_name, 
  						last_name: Faker::Name.last_name,
  						email: Faker::Internet.email,
  						password: 'password')
end

10.times do
	Category.create(name: Faker::Lorem.word.capitalize)
end

50.times do
	Idea.create(title: Faker::Name.title,
							description: Faker::Lorem.sentence,
							user_id: rand(1..User.all.count),
							category_id: rand(1..Category.all.count))
end

100.times do
	Vote.create(idea_id: rand(1..Idea.all.count),
							voter_id: rand(1..User.all.count))
end

Idea.all.each do |idea|
	2.times do 
		Image.create(url: Faker::Internet.url, idea_id: idea.id)
	end
end
