class AddLatitudeToSpreeStores < ActiveRecord::Migration
  def change
    add_column :spree_stores, :latitude, :string
  end
end
