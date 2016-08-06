# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

20.times do
  User.create!(username: Faker::Internet.user_name, password: "password")
end
20.times do
  sub = Sub.create!(title: Faker::Company.catch_phrase, description: Faker::Lorem.paragraph, moderator_id: rand(1..20))

  20.times do
    post = Post.create!(title: Faker::Space.constellation, url: Faker::Company.logo, content: Faker::Lorem.paragraph, author_id: rand(1..20), sub_ids: [sub.id])
    5.times do
      Comment.create!(content: Faker::Lorem.sentence, author_id: rand(1..20), post_id: post.id)
    end
  end

end
