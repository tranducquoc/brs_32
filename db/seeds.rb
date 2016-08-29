User.create!(name: "quoc",
             email: "quoc@gmail.com",
             password: "123456",
             password_confirmation: "123456")

User.create!(name: "admin",
             email: "admin@gmail.com",
             password: "123456",
             password_confirmation: "123456",
             role: 0)
Category.create!(name: "Information Technology")
Category.create!(name: "Short Story")
Category.create!(name: "Novel")
Category.create!(name: "Sience")
Category.create!(name: "Economy")

Author.create!(name: "Jason Quinn")
Author.create!(name: "J.K. Rowling")
Author.create!(name: "Napoleon Hill")
Author.create!(name: "Nguyen Du")

Language.create!(name: "English")
Language.create!(name: "Vietnamese")

Publisher.create!(name: "B & W Publishing",
  address: "Chicago - USA",
  phone_number: "08-5656-56")
Publisher.create!(name: "BBC Books",
  address: "New York - USA",
  phone_number: "08-2112-21")
Publisher.create!(name: "Kim Dong",
  address: "Ho Chi Minh - VN",
  phone_number: "84-123456")

Book.create!(
    title: "Think and Grow Rich",
    cover_image_name: "book1.jpg",
    number_of_pages: 200,
    description: "Think And Grow Rich has earned itself the reputation of being considered a textbook for actionable techniques that can help one get better at doing anything, not just by rich and wealthy, but also by people doing wonderful work in their respective fields.",
    publish_date: DateTime.strptime("28/08/2016", "%d/%m/%y"),
    price: 500.000,
    author_id: 3,
    category_id: 5,
    publisher_id: 1,
    language_id: 1,
    is_in_library: true,
    average_rating: 5.0,
  )

Book.create!(
    title: "Harry Potter and the Philosopher's Stone",
    cover_image_name: "book2.jpg",
    number_of_pages: 200,
    description: "Harry Potter and the Philosopher’s Stone is the first novel of the much appreciated Harry Potter series. An abridged version of the same novel, this book has been brought out by Bloomsbury Press for children aged between eight and twelve years.",
    publish_date: DateTime.strptime("28/08/2016", "%d/%m/%y"),
    price: 500.000,
    author_id: 2,
    category_id: 3,
    publisher_id: 2,
    language_id: 1,
    is_in_library: true,
    average_rating: 5.0,
  )
