class Order
  include ActiveModel::Model
  # purchase_recordsテーブルとshipping_areasテーブルに保存したいカラム名
  attr_accessor :postal_code, :prefecture, :city, :address, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    # shipping_areaモデルのバリデーション
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :phone_number,
              format: { with: /\A[0-9]{10,11}\z/, message: 'must be 10 digits or 11 digits number, not full width' }
    # purchase_recordモデルのバリデーション
    validates :user_id
    validates :item_id
    # トークンのバリデーション
    validates :token
  end

  def save
    # 購入情報を保存し、変数purchase_recordに代入する
    purchase_record = PurchaseRecord.create(user_id: user_id, item_id: item_id)
    # 住所を保存する
    # purchase_record_idには、変数purchase_recordのidと指定する
    ShippingArea.create(postal_code: postal_code, prefecture: prefecture, city: city, address: address,
                        building_name: building_name, phone_number: phone_number, purchase_record_id: purchase_record.id)
  end
end
