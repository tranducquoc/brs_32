FactoryGirl.define do
  factory :activity do
    user
    target_id 1
    action_type 0

    factory :activity_with_likes do
      transient do
        likes_count 5
      end

      after(:create) do |activity, evaluator|
        create_list(:like, evaluator.likes_count, activity: activity)
      end
    end
  end
end
