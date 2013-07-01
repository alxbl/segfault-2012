# -*- coding: utf-8 -*-
class Article < ActiveRecord::Base
  SLUG_REGEX = /^[a-z]([a-z]|\-[^\-])*[a-z]*$/i
  CACHE_KEY = 'article_cache'
  attr_accessible :allow_comments, :md, :html, :header, :slug

  validates :allow_comments, presence: true
  validates :slug, presence: true,
                   length: {maximum: 255},
                   format: {with: SLUG_REGEX}
  validates :md, presence: true
  validates :html, presence: true
  validates :header, presence: true, length: {maximum: 255}

  has_many :taggings, :dependent => :delete_all
  has_many :tags, :through => :taggings
  belongs_to :language
  has_many :comments

  def date
    created_at.strftime '%B %d %Y' # TODO: Internationalize
  end

  def to_param
    slug
  end

  # Tags an article with the given tag, creating it if it does not already exist.
  #
  # +tag+:: A tag to associate to this article.
  def add_tag(tag)
    t = Tagging.new()
    t.article = self
    t.tag = tag
    begin
      self.taggings << t
    rescue # Already tagged
      false
    end
  end

  def remove_tag(tag)
    self.taggings.each do |t|
      next unless t.tag == tag
      self.taggings.delete(t)
    end
  end

  def self.filter(locale)
    joins(:language).where('languages.code' => locale || 'en')
  end

  def self.paginate(page, locale='en')
    filter(locale).order("created_at DESC").paginate(:page => page, :per_page => 6) # TODO: Move to APP_CONFIG?
  end

  def self.from_file(slug, lang)
    # Lazily instantiate markdown
    @@md ||= Redcarpet::Markdown.new(Pygmentizer, :autolink => true, :fenced_code_blocks => true, :no_intra_emphasis => true)

    # Locate the file based on its slug
    path = Rails.root.join('public', 'articles', lang, "#{slug}.md")
    begin
      md = IO.read(path)
      data = md.split /\n\n|\r\n\r\n/, 2 # Split at the first two consecutive line breaks.
      meta = Article.parse_metadata(data[0])
      meta["allow comments"] = true if !meta.has_key? "allow comments" # Allow comments by default.
      content = data[1]

      l = Language.find_by_code(lang)
      a = Article.new(slug: slug,
                          header: meta["title"],
                          md: content, html: @@md.render(content),
                          allow_comments: meta["allow comments"])
      a.language = l
      taglist = meta["tags"].split /,|、/ if meta.has_key? "tags"
      taglist.map { |t| a.add_tag Tag.from_name(t.strip) }
      a.save
#    rescue
#      a = nil
    end
    return a
  end

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
    rescue
      # Parsing failed, return an empty or partial hash.
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
