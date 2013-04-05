class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.with_options :null => false do |o|
        o.string :name
        o.integer :freq, :default => 0
      end

      t.timestamps
    end

    add_index :tags, :name, :unique => true
  end
end
