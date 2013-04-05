class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.with_options :null => false do |o|
        o.string :slug
        o.string :header
        o.text :body
        o.boolean :allow_comments, :default => true
      end

      t.timestamps
    end

    add_index :articles, :slug, :unique => true
  end
end
