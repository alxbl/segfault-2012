class NormalizeSchema < ActiveRecord::Migration
  def change
    # -- Normalize `articles` --
    remove_index  :articles, :language_id
    remove_column :articles, :language_id
    remove_column :articles, :md
    remove_column :articles, :html
    remove_column :articles, :header
    remove_index  :articles, :slug
    add_index     :articles, :slug, unique: true

    # -- `taggings` Relations --
    remove_index  :taggings, [:tag_id, :article_id]
    rename_column :taggings, :article_id, :translation_id
    add_index     :taggings, [:tag_id, :translation_id], unique: true

    # -- `comments` Relations --
    remove_index  :comments, :article_id
    rename_column :comments, :article_id, :translation_id
    add_index     :comments, :translation_id
  end
end
