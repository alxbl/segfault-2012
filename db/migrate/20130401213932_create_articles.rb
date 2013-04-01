class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :header
      t.text :body
      t.string :slug
      t.boolean :allow_comments

      t.timestamps
    end
  end
end
