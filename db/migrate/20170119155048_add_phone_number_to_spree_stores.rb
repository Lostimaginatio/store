class AddPhoneNumberToSpreeStores < ActiveRecord::Migration
  def change
    remove_column :spree_stores, :phone_number
    add_column :spree_stores, :phone_number, :string
  end
end
