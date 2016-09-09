FactoryGirl.define do
  factory :user do |u|
    name "User"
    u.sequence(:email) { |n| "user#{n}@awesome.com"}
    password "111111"
    role 1

    factory :other_user do
      name "Other user"
      email "other_user@mail.com"
      password "111111"
      role 1
    end

    factory :admin do
      name "Admin"
      email "admin@mail.com"
      password "111111"
      role 0
    end

    factory :user_with_requests do
      transient do
        requests_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:request, evaluator.requests_count, user: user)
      end
    end
  end
end
