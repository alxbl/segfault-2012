class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.with_options :null => false do |o|
        o.integer :tag_id
        o.integer :article_id
      end

      t.timestamps
    end

    add_index :taggings, [:tag_id, :article_id], :unique => true
  end
end
