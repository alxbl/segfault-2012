class Comment < ActiveRecord::Base
  attr_accessible :body, :author, :flagged

  belongs_to :article
end
