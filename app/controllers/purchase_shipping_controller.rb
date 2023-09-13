class PurchaseShippingController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id]) # @item を定義する
    @purchase_shipping = PurchaseShipping.new
  end

  def new
  end

  def create
    @item = Item.find(params[:item_id]) # @item を定義する
    @purchase_shipping = PurchaseShipping.new(purchase_shipping_params)
    if @purchase_shipping.valid?
      pay_item
      # PurchaseRecord を作成し、データベースに保存
      purchase_record = PurchaseRecord.create(
        user_id: current_user.id,
        item_id: @item.id
      )

      # ShippingArea を作成し、データベースに保存
      shipping_area = ShippingArea.create(
        # 必要な発送先情報を設定
      )

      return redirect_to root_path
    else
      render :index
    end
  end


  private

  def purchase_shipping_params
    params.require(:purchase_shipping).permit(:postal_code, :prefecture, :city, :address, :building_name,
                                          :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end

  def pay_item
    # 支払い処理を実装する（実際の支払いゲートウェイを使用するか、テスト用の処理を記述）
  end
end
