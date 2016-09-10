FactoryGirl.define do
  factory :book do
    title "Titleofthebook"
    cover_image_name "book.jpg"
    number_of_pages "100"
    description "This is description of the book! I say again: This is description of the book!"
    publish_date Faker::Date.between(2.days.ago, Date.today)
    price 100
    author
    category
    publisher
    language
    is_in_library true
    average_rating 4
  end
end
