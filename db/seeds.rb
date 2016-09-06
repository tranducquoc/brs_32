User.create!(name: "User",
             email: "user@mail.com",
             password: "111111",
             password_confirmation: "111111")

User.create!(name: "faker1",
             email: "faker1@mail.com",
             password: "123456",
             password_confirmation: "123456",
)

User.create!(name: "faker2",
             email: "faker2@mail.com",
             password: "123456",
             password_confirmation: "123456",
)

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
  cover_image_name: "734_Think-and-grow-rich.jpg",
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
Book.create!(
  title: "Truyen Kieu",
  cover_image_name: "truyen_kieu.jpg",
  number_of_pages: 2000,
  description: "Truyện Kiều, tên gốc là Đoạn trường tân thanh, là truyện thơ kinh điển trong Nền Văn học Việt Nam, được viết bằng chữ Nôm theo thể lục bát của Nguyễn Du, gồm 3254 câu, dựa theo tiểu thuyết  Kim Vân Kiều truyện của Thanh Tâm Tài Nhân",
  publish_date: DateTime.strptime("31/08/2016", "%d/%m/%y"),
  price: 500.000,
  author_id: 4,
  category_id: 2,
  publisher_id: 3,
  language_id: 2,
  is_in_library: false,
  average_rating: 5.0
)

Request.create!(
  user_id: 1,
  book_id: 3,
  status: 0
)

Request.create!(
  user_id: 2,
  book_id: 3,
  status: 1
)

Request.create!(
  user_id: 3,
  book_id: 3,
  status: 2
)

Activity.create!(
  user_id: 1,
  target_id: 1,
  action_type: 0
)

Activity.create!(
  user_id: 2,
  target_id: 1,
  action_type: 1
)

Activity.create!(
  user_id: 1,
  target_id: 1,
  action_type: 2
)

Activity.create!(
  user_id: 1,
  target_id: 1,
  action_type: 3
)

Activity.create!(
  user_id: 1,
  target_id: 2,
  action_type: 2
)

Activity.create!(
  user_id: 1,
  target_id: 1,
  action_type: 4
)

Activity.create!(
  user_id: 1,
  target_id: 1,
  action_type: 5
)

Activity.create!(
  user_id: 1,
  target_id: 1,
  action_type: 6
)
