class Article < ActiveRecord::Base
  attr_accessible :allow_comments, :body, :header, :slug
end
