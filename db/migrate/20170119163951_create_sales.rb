class CreateSales < ActiveRecord::Migration
  def self.up
    create_table :sales do |t|
      t.string :name
      t.text :content

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :sales
  end
end
