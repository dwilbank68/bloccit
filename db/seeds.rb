require 'faker'

5.times do
  user = User.new(
      name: Faker::Name.name,
      email:Faker::Internet.email,
      password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

topic_num = 1
150.times do
  Topic.create(
      name:       "Topic " + topic_num.to_s + " " + Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
  )
  topic_num += 1
end
topics = Topic.all

post_num = 1
250.times do
  post = Post.create!(
      user: users.sample,
      topic: topics.sample,
      title: "Post " + post_num.to_s + " " + Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph
    )

    post.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
    post.create_vote
    post.update_rank
    post_num += 1
end
posts = Post.all

500.times do
  Comment.create!(
    post: posts.sample,
    body: Faker::Lorem.paragraph,
    user_id: (1..5).to_a.sample
 )
end

admin = User.new(
    name:     'Admin User',
    email:    'admin@example.com',
    password: 'helloworld',
    role:     'admin'
)
admin.skip_confirmation!
admin.save!

# Create a moderator
moderator = User.new(
    name:     'Moderator User',
    email:    'moderator@example.com',
    password: 'helloworld',
    role:     'moderator'
)
moderator.skip_confirmation!
moderator.save!

# Create a member
member = User.new(
    name:     'Member User',
    email:    'dwilbank@gmail.com',
    password: '1aberath'
)
member.skip_confirmation!
member.save!

puts 'Seed finished'
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"