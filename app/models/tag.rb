class Tag < ActiveRecord::Base
  attr_accessible :name
  validates :freq, presence: true
  validates :name, presence: true, length: {maximum: 50}

  has_many :taggings
  has_many :articles, :through => :taggings
end
