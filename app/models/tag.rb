class Tag < ActiveRecord::Base
  attr_accessible :name
  validates :freq, presence: true
  validates :name, presence: true, length: {maximum: 50}

  has_many :taggings
  has_many :translations, :through => :taggings

  def to_param
    name
  end

  def self.from_name(name)
    t = Tag.find_or_create_by_name(name)
    return t
  end
end
