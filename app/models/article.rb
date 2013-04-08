class Article < ActiveRecord::Base
  attr_accessible :allow_comments, :body, :header, :slug
  validates :allow_comments, presence: true
  # SLUG_REGEX = //
  validates :slug, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 255}
  validates :body, presence: true
  validates :header, presence: true

  has_many :taggings
  has_many :tags, :through => :taggings
  has_many :comments
end
