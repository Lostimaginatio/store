class AddPhoneToStore < ActiveRecord::Migration
  def change
    add_column :spree_stores, :phone_number, :string
  end
end
