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
    @@md ||= Redcarpet::Markdown.new(Pygmentizer, :autolink => true, :fenced_code_blocks => true, :no_intra_emphasis => true)
    @@langs ||= Language.all

    logger.info "Article.from_file(#{slug})"
    a = Article.where(slug: slug).first_or_initialize # Create or update
    @@langs.each do |lang|
      path = Rails.root.join('public', 'articles', lang.code, "#{slug}.md")
      logger.debug "  Default lookup path is `#{path}`"
      begin
        md = IO.read(path)
        data = md.split /\n\n|\r\n\r\n/, 2 # Split at the first two consecutive line breaks.
        meta = Article.parse_metadata(data[0])
        meta["allow comments"] = true if !meta.has_key? "allow comments" # Allow comments by default.
        content = data[1]

        if lang.code == 'en' # FIXME: This should only be done if we have at least the fallback translation
          a.allow_comments = meta["allow comments"]
          begin 
            a.created_at = DateTime.parse(meta["date"]) # Support persisting dates
          rescue
          end 
          a.save!
          logger.info "  Created article"
        end

        t = Translation.where(language_id: lang, article_id: a).first_or_initialize # Create or update translation
        t.language = lang
        t.article = a
        t.markdown = md
        t.html_cache = @@md.render(content)
        #t.description = meta["description"] || nil
        t.inject_metadata meta
        t.save!
        logger.info "  Added translation for #{lang.name}"
      rescue # FIXME: Better error handling.
        return nil if lang.code == 'en' # If we can't find the default language, no article is created.
      end
    end
    logger.info "  Cleared RSS cache"
    ActionController::Base.new.expire_fragment(Article::RSS_CACHE)
    return a
  end

  private
  def self.parse_metadata(content)
    metadata = Hash.new()
    begin
      content.lines.each do |p|
        k, v = p.split ":", 2
        next if k == nil || v == nil
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
