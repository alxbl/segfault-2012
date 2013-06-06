FactoryGirl.define do
  factory :article do
    sequence(:slug, 'a')   { |n| "article-number-#{n}" }
    sequence(:md, 'a')     { |n| "# This is article #{n.upcase}" }
    sequence(:html, 'a')   { |n| "<h1>This is article #{n.upcase}" }
    sequence(:header, 'a') { |n| "Article #{n.upcase}" }
  end

  factory :tag do
    sequence(:name) { |n| "tag#{n}" }
  end
end
