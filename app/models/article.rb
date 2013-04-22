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

  has_many :taggings
  has_many :tags, :through => :taggings
  has_many :comments

  def date
    created_at.strftime '%B %d %Y' # TODO: Internationalize
  end

  def to_param
    slug
  end
end
