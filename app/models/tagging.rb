class Tagging < ActiveRecord::Base
  belongs_to :translation
  belongs_to :tag #, :counter_cache => :freq # Disable counter cache for now
end
