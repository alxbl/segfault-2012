namespace :app do
  desc "Update the database of articles."
  task :crawl => :environment do
    require 'redcarpet'
    # Use English as a default language and check for translations.
    md_files = Dir.glob(Rails.root.join('public', 'articles', 'en', '*.md'))
    p "Found #{md_files.size} article(s) available."

    md_files.each do |f|
      p f
    end
    current_articles = Article.all
    p "Loaded #{current_articles.size} existing article(s)."
    current_articles.each do |a|
      # TODO: Parse and create non-indexed articles.
    end
  end
end
