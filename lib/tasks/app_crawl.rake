namespace :app do
  desc "Update the database of articles."
  task :crawl => :environment do
    require 'redcarpet'
    # Use English as a default language and check for translations.
    md_files = Dir.glob(Rails.root.join('public', 'articles', 'en', '*.md'))
    slugs = md_files.map { |f| f[%r{/(?<slug>[^\./]+)\.md}, "slug"] } # Extract <slug>.md from the path.

    current_articles = Article.all
    current_articles.each do |a|
      slugs.delete a.slug
    end

    p "Indexing #{slugs.size} new article(s)..."

    slugs.each do |s|
      next if :environment == "production" && s == "sample" # Don't index the sample markdown in production.

      # TODO: Refactor languages to be a table in the DB.
      p "Indexing `#{s}`"
      en = Article.from_file(s)
    end
  end
end
