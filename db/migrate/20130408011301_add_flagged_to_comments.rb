class AddFlaggedToComments < ActiveRecord::Migration
  def change
    add_column :comments, :flagged, :integer, :default => 0, :null => false
  end
end
