# -*- coding: utf-8 -*-
class Translation < ActiveRecord::Base
  attr_accessible :markdown, :html_cache, :header

  validates :markdown, presence: true
  validates :html_cache, presence: true
  validates :header, presence: true, length: {maximum: 255}

  belongs_to :article
  belongs_to :language

  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings
  has_many :comments, :dependent => :destroy

  # Tags an article with the given tag, creating it if it does not already exist.
  #
  # +tag+:: A tag to associate to this article.
  def add_tag(tag)
    t = Tagging.new()
    t.translation = self
    t.tag = tag
    begin
      self.taggings << t
    rescue # Already tagged
      false
    end
  end

  def remove_tag(tag)
    self.taggings.each do |t|
      next unless t.tag == tag
      self.taggings.delete(t)
    end
  end

  def inject_metadata(meta)
    # Tags
    taglist = meta["tags"].split %r{,|、} if meta.has_key? "tags"
    taglist.map { |tag| add_tag Tag.from_name(tag.strip) }

    # Title
    self.header = meta["title"]
  end
end
