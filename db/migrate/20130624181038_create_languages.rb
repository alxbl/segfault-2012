class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.with_options :null => false do |o|
        o.string :code
        o.string :name_en
        o.string :name
      end
    end

    add_index :languages, :code, :unique => true
  end
end
