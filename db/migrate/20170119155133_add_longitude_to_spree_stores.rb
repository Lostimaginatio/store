class AddLongitudeToSpreeStores < ActiveRecord::Migration
  def change
    add_column :spree_stores, :longitude, :string
  end
end
