class CreateDeliveryAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_addresses do |t|
      t.string :post_code, null: false
      t.integer :prefecture_id, null: false
      t.string :city_town, null: false
      t.string :street_number, null: false
      t.string :building_name, default: ""
      t.integer :phone_number, null: false
      t.references :purchase_order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
