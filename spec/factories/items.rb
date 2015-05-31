FactoryGirl.define do
  factory :item do
    sequence(:title) { |n| "title #{n}" }
    sequence(:body) { |n| "body #{n}" }
    user
    tag_list { ['tag_1'] }
  end
end
