class AddDescriptionToTranslation < ActiveRecord::Migration
  def change
    add_column :translations, :description, :string
  end
end
