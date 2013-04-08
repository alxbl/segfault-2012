class RenameNameToAuthorInComments < ActiveRecord::Migration
  def up
    rename_column :comments, :name, :author
  end

  def down
    rename_column :comments, :author, :name
  end
end
