class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_charge_type
  belongs_to_active_hash :delivery_day
  belongs_to_active_hash :prefecture

  with_options presence: true do
    validates :name, :description, :category, :condition, :delivery_charge_type, :delivery_day, :prefecture, :price
  end

  with_options numericality: { other_than: 0 } do
    validates :category_id, :condition_id, :delivery_charge_type_id, :delivery_day_id, :delivery_from_id
  end
  
end
