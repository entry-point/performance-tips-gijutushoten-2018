Status.create!(status: 'ok')

insert_lines_forusers = (User.count - 5_000_000).abs
puts 'insert of seeds for users...'
users = []
columns_for_users = [:name, :age, :sex, :email]
insert_lines_forusers.times do
  users << [
    Faker::Name.name,
    Faker::Number.between(0, 120),
    ['male', 'female'].sample,
    Faker::Internet.email
  ]

  if users.length == 10_000
    print '.'
    User.import columns_for_users, users, validate: false
    users = []
  end
end
