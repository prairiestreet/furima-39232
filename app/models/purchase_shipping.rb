class PurchaseShipping 
  include ActiveModel::Model
  # purchase_recordsテーブルとshipping_areasテーブルに保存したいカラム名
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :user_id, :item_id

  with_options presence: true do
    # shipping_areasモデルのバリデーション
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: 'must be 10 digits or 11 digits number, not full width' }
    # purchase_recordsモデルのバリデーション
    validates :user_id
    validates :item_id
  end

  def save
    # 購入情報を保存し、変数purchase_recordに代入する
    purchase_record = PurchaseRecord.create(user_id: user_id, item_id: item_id)
    # 住所を保存する
    # purchase_record_idには、変数purchase_recordのidと指定する
    ShippingArea.create(postal_code: postal_code, prefecture: prefecture, city: city, address: address, building_name: building_name, purchase_record_id: purchase_record.id)
  end
end
