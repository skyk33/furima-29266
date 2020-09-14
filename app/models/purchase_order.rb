class PurchaseOrder < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :delivery_address

  # attr_accessor :token
  # validates :user_id, :item_id, presence: true
  # validates :token, presence: true
end
