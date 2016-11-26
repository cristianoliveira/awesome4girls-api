p "Creating seed data for this app..."

user = User.find_by_name("admin")
unless user
  user = User.create(name: "admin",
                     password: "admin",
                     role: User::ROLE_ADMIN)
end
p "Created admin user: #{user.name} pass: #{user.password}"

user = User.find_by_name("user")
unless user
  user = User.create(name: "user",
                     password: "user",
                     role: User::ROLE_USER)
end
p "Created simple user: #{user.name} pass: #{user.password}"
