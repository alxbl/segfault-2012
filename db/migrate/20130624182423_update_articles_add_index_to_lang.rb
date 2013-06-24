class  UpdateArticlesAddIndexToLang < ActiveRecord::Migration
  def change
    rename_column :articles, :lang, :language_id
    add_index :articles, :language_id
  end
end
