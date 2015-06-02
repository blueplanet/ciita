FactoryGirl.define do
  factory :comment do
    item
    user
    sequence(:body) { |n| "comment body #{n}" }
  end
end
