class AddLangToArticles < ActiveRecord::Migration
  def up
    add_column :articles, :lang, :integer
    change_column :articles, :lang, :integer, :null => false, :default => 1
  end

  def down
    remove_column :articles, :lang
  end
end
