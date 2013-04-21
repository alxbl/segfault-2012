FactoryGirl.define do
  factory :article do
    sequence(:slug, 'a')   { |n| "article-number-#{n}" }
    sequence(:body, 'a')   { |n| "This is article #{n.upcase}" }
    sequence(:header, 'a') { |n| "Article #{n.upcase}" }
  end
end
