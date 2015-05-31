FactoryGirl.define do
  factory :item do
    sequence(:title) { |n| "title #{n}" }
    sequence(:body) { |n| "body #{n}" }
    tag_list { ['tag_1'] }
  end
end
