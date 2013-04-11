class Comment < ActiveRecord::Base
  attr_accessible :body, :author, :flagged
  belongs_to :article

  validates :body, length: {maximum: 300}
  validates :article, :presence => true
  validates :flagged, :presence => true
end
