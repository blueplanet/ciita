FactoryGirl.define do
  factory :item do
    sequence(:title) { |n| "title #{n}" }
    sequence(:body) { |n| "内容です！テストテスト・テスト body #{n}" }
    user
    tag_list { ['tag_1'] }
  end
end
