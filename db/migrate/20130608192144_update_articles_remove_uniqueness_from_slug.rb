class UpdateArticlesRemoveUniquenessFromSlug < ActiveRecord::Migration
  def up
    # Should not be unique since translations will go in the same table.
    remove_index :articles, :slug
    add_index :articles, :slug, :unique => false
  end

  def down
    remove_index :articles, :slug
    add_index :articles, :slug, :unique => true
  end
end
