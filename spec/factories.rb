FactoryGirl.define do
  factory :translation do
    sequence(:markdown)   { |n| "# This is article #{n}" }
    sequence(:html_cache) { |n| "<h1>This is article #{n}</h1>" }
    sequence(:header)     { |n| "Article #{n}" }
  end

  factory :article do
    sequence(:slug, 'a')   { |n| "article-number-#{n}" }

    # Create one translation per language
    after(:build) do |a|
      Language.all.each { |l| a.translations << FactoryGirl.build(:translation, :article => a, :language => l) }
    end
    after(:create) { |a| a.translations.each { |tr| tr.save! } }
  end

  factory :tag do
    sequence(:name) { |n| "tag#{n}" }
  end
end
