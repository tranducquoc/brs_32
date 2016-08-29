User.create!(name: "quoc",
             email: "quoc@gmail.com",
             password: "123456",
             password_confirmation: "123456")

User.create!(name: "admin",
             email: "admin@gmail.com",
             password: "123456",
             password_confirmation: "123456",
             role: 0)
