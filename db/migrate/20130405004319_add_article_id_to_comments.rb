class AddArticleIdToComments < ActiveRecord::Migration
  def up
    add_column :comments, :article_id, :integer
    change_column :comments, :article_id, :integer, :null => false # Gotta play nice with SQLite3 ...
    add_index  :comments, :article_id
  end

  def down
    remove_column :comments, :article_id
    remove_index :comments, :article_id
  end
end
