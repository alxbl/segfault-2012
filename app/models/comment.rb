class Comment < ActiveRecord::Base
  attr_accessible :body, :author, :flagged
  belongs_to :translation

  validates :body, length: {maximum: 300}
  validates :translation, :presence => true
  validates :flagged, :presence => true
end
