class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_charge_type
  belongs_to_active_hash :delivery_schedule
  belongs_to_active_hash :prefecture
  has_one_attached :image
  belongs_to :user

  with_options presence: true do
    validates :name, :description, :category, :condition, :delivery_charge_type, :delivery_schedule, :prefecture, :image
    validates :price, numericality: { only_integer: true, message: 'should be numbers' }, inclusion: { in: 300..9_999_999, message: 'is out of price range' }
  end

  with_options numericality: { other_than: 0, message: 'is not selected' } do
    validates :category_id, :condition_id, :delivery_charge_type_id, :delivery_schedule_id, :prefecture_id
  end
end
