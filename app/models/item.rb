class Item < ApplicationRecord

  belongs_to :user
  has_one :purchase_record
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :prefectures
  belongs_to_active_hash :preparation_days
  has_one_attached :image
end
