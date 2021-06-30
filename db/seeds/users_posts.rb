users = []
(1..10).to_a.each do |id|
  users << {
    id: id,
    username: "dy#{id}",
    password_digest: BCrypt::Password.create("12345678"),
    created_at: Time.now,
    updated_at: Time.now
  }
end

User.insert_all!(users)

count = 1
posts = []
users.each do |user|
  10.times do
    posts << {
      id: count,
      user_id: user[:id],
      title: Faker::Name.title,
      content: Faker::Lorem.paragraph,
      created_at: Time.now,
      updated_at: Time.now
    }
    count += 1
  end
end

Post.insert_all(posts)

count = 1
comments = []
posts.each do |post|
  10.times do
    comments << {
      id: count,
      user_id: users.sample[:id],
      post_id: post[:id],
      content: Faker::Lorem.paragraph,
      created_at: Time.now,
      updated_at: Time.now
    }
    count += 1
  end
end

Comment.insert_all(comments)
