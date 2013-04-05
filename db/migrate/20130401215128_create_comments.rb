class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.with_options :null => false do |o|
        o.string :name, :default => 'Anonymous'
        o.text :body
      end

      t.timestamps
    end
  end
end
