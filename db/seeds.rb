Status.create!(status: 'ok')

insert_lines_for_users = (1_500_000 - User.count).abs
puts 'insert of seeds for users...'
users = []
users_bar = ProgressBar.new(insert_lines_for_users)
columns_for_users = [:name, :age, :sex, :email]
insert_lines_for_users.times do
  users << [
    Faker::Name.name,
    Faker::Number.between(0, 120),
    ['male', 'female'].sample,
    Faker::Internet.email
  ]

  if users.length == 10_000
    User.import columns_for_users, users, validate: false
    users_bar.increment! 10_000
    users = []
  end
end

insert_lines_for_comments = (100_000 - Comment.count).abs
puts 'insert of seeds for comments...'
comments = []
comments_bar = ProgressBar.new(insert_lines_for_comments)
columns_for_comments = [:user_id, :comment]
user_count = User.count
insert_lines_for_comments.times do
  comments << [
    rand(1..user_count),
    Faker::Twitter.user[:status][:text]
  ]

  if comments.length == 10_000
    Comment.import columns_for_comments, comments, validate: false
    comments_bar.increment! 10_000
    comments = []
  end
end

puts 'insert of seeds for dice'
DiceLog.create!(roll: rand(1..6))
