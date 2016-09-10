FactoryGirl.define do
  factory :user_book do
    user
    book
    is_favorite true

    factory :user_book_reading do
      user
      book
      status 1
    end

    factory :user_book_read do
      user
      book
      status 2
    end
  end
end
