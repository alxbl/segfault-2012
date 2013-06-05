class RenameBodyToMdInArticles < ActiveRecord::Migration
  def change
    rename_column :articles, :body, :md
  end
end
