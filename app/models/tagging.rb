class Tagging < ActiveRecord::Base
  belongs_to :translation
  belongs_to :tag, :counter_cache => :freq
end
