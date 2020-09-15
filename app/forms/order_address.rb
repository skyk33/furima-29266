class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token, :post_code, :prefecture_id, :city_town, :street_number, :building_name, :phone_number, :purchase_order_id

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Should be half-width numbers and total 8 characters including hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 0, message: 'is not selected' }
    validates :city_town
    validates :street_number
    validates :phone_number, format: { with: /\A0[5789]0\d{8}\z/, message: 'is invalid. Should be half-width numbers (11 characters). Should not include hypen(-)' }
  end

  def save
    order = PurchaseOrder.create(user_id: user_id, item_id: item_id)
    DeliveryAddress.create(post_code: post_code, prefecture_id: prefecture_id, city_town: city_town, street_number: street_number, building_name: building_name, phone_number: phone_number, purchase_order_id: order.id)
  end
end
