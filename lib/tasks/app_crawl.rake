namespace :app do
  desc "Update the database of articles."
  task :crawl => :environment do
    require 'redcarpet'
    # TODO: Add extensions for parsing metadata.
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true)

    md_files = Dir.glob(Rails.root.join('public', 'articles', '*.md'))
    p "Found #{md_files.size} article(s) available."

    current_articles = Article.all
    p "Loaded #{current_articles.size} existing article(s)."
    current_articles.each do |a|
      # TODO: Parse and create non-indexed articles.
    end
  end
end
