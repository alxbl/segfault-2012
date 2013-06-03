class Article < ActiveRecord::Base
  attr_accessible :allow_comments, :body, :header, :slug

  validates :allow_comments, presence: true
  SLUG_REGEX = /^[a-z]([a-z]|\-[^\-])*[a-z]*$/i
  validates :slug, presence: true,
                   uniqueness: {case_sensitive: false},
                   length: {maximum: 255},
                   format: {with: SLUG_REGEX}
  validates :body, presence: true
  validates :header, presence: true, length: {maximum: 255}

  has_many :taggings, :dependent => :delete_all
  has_many :tags, :through => :taggings
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
end
