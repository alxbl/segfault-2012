# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130608192144) do

  create_table "articles", :force => true do |t|
    t.string   "slug",                             :null => false
    t.string   "header",                           :null => false
    t.text     "md",                               :null => false
    t.boolean  "allow_comments", :default => true, :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.text     "html",                             :null => false
    t.integer  "lang",           :default => 1,    :null => false
  end

  add_index "articles", ["slug"], :name => "index_articles_on_slug"

  create_table "comments", :force => true do |t|
    t.string   "author",     :default => "Anonymous", :null => false
    t.text     "body",                                :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "article_id",                          :null => false
    t.integer  "flagged",    :default => 0,           :null => false
  end

  add_index "comments", ["article_id"], :name => "index_comments_on_article_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id",     :null => false
    t.integer  "article_id", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "taggings", ["tag_id", "article_id"], :name => "index_taggings_on_tag_id_and_article_id", :unique => true

  create_table "tags", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "freq",       :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

end
