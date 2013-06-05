class AddHtmlToArticles < ActiveRecord::Migration
  def up
    add_column :articles, :html, :text
    change_column :articles, :html, :text, :null => false
  end

  def down
    remove_column :articles, :html
  end
end
