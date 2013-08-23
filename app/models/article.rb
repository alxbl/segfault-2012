# -*- coding: utf-8 -*-
class Article < ActiveRecord::Base
  SLUG_REGEX = /^[a-z]([a-z]|\-[^\-])*[a-z]*$/i
  RSS_CACHE = 'rss_cache'
  attr_accessible :allow_comments, :slug

  validates :allow_comments, presence: true
  validates :slug, presence: true,
                   length: {maximum: 255},
                   format: {with: SLUG_REGEX}

  has_many :translations, :dependent => :destroy
  default_scope { order "created_at DESC" }

  def date
    created_at.strftime '%B %d %Y' # TODO: Internationalize
  end

  def to_param
    slug
  end

  def translation # TODO: Make private
    Translation.joins(:language).where("languages.code = '#{I18n.locale}'").find_by_article_id(self.id)
  end

  def title
    translation.header
  end

  # Abstract API
  def tags
    translation.tags
  end

  def content
    translation.html_cache
  end

  def comments
    [] # TODO: Methood stub
  end

  def markdown
    translation.markdown
  end

  def self.page(page)
    joins(translations: :language).where("languages.code = '#{I18n.locale}'")
      .paginate(:page => page, :per_page => 6) # TODO: Move to APP_CONFIG?
  end

  def self.from_file(slug)
    # Lazily instantiate markdown
    @@md ||= Redcarpet::Markdown.new(Pygmentizer, :autolink => true, :fenced_code_blocks => true, :no_intra_emphasis => true)
    @@langs ||= Language.all # Cache the list of languages for this request

    a = Article.new(slug: slug)

    @@langs.each do |lang|
      # Locate the file based on its slug
      path = Rails.root.join('public', 'articles', lang.code, "#{slug}.md")

      begin
        md = IO.read(path)
        data = md.split /\n\n|\r\n\r\n/, 2 # Split at the first two consecutive line breaks.

        meta = Article.parse_metadata(data[0])
        meta["allow comments"] = true if !meta.has_key? "allow comments" # Allow comments by default.
        content = data[1]

        # Create the article entry.
        if lang.id == 1
            a.allow_comments = meta["allow comments"]
            a.save!
        end

        # Create the translation for the current language
        t = Translation.new()
        t.language = lang
        t.article = a
        t.markdown = content
        t.html_cache = @@md.render(content)
        t.inject_metadata meta
        t.save!
       rescue
        return nil if lang.id == 1 # If we can't find the default language, no article is created.
      end
    end
    # Unfortunately need to create a controller to expire from within model.
    ActionController::Base.new.expire_fragment(Article::RSS_CACHE)
    return a
  end

  #private #TODO: Uncomment
  def self.parse_metadata(content)
    metadata = Hash.new()
    begin
      content.lines.each do |p|
        pp = p.split ":", 2
        next unless pp.size == 2
        k = pp[0]
        v = pp[1]
        metadata[k.strip.downcase] = v.strip
      end
    rescue # Parsing failed, return an empty or partial hash.
    end
    return metadata
  end
end

class Pygmentizer < Redcarpet::Render::HTML
  def block_code(code, language)
    require 'pygmentize'
    Pygmentize.process(code, language) if language
  end
end
