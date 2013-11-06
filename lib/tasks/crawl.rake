namespace :crawl do
  desc "Indexes an article with the given slug in the database."
  task :index, [:slug] => :environment do |t, args|
    index_article "#{args[:slug]}"
  end

  desc "Searches for new articles and indexes them."
  task :new => :environment do
    require 'redcarpet'
    md_files = Dir.glob(Rails.root.join('public', 'articles', 'en', '*.md')) # Scan English articles. Translations will be detected magically.
    slugs = md_files.map { |f| f[%r{/(?<slug>[^\./]+)\.md}, "slug"] } # Extract <slug>.md from the path.
    Article.all.each { |a| slugs.delete a.slug }
    puts slugs.size > 0 ? "Indexing #{slugs.size} new article(s)\n" : "No new articles found."

    slugs.each do |s|
      next if Rails.env == "production" && s == "sample" # Don't index the sample markdown in production.
      index_article s
    end
  end
end

def index_article(s)
  a = Article.from_file(s)
  puts "Indexed `#{s}.md`...#{a ? 'ok' : 'fail'}"
end
