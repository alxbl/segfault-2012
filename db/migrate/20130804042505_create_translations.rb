class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.with_options :null => false do |o|
        o.integer :article_id
        o.integer :language_id
        o.string  :header
        o.text    :markdown
        o.text    :html_cache
      end
    end

    add_index :translations, [:article_id, :language_id], unique: true
  end
end
