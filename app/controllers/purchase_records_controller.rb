class PurchaseRecordsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @item = Item.find(params[:item_id]) # @item を定義する
      @purchase_record = PurchaseRecord.new
    end
  
    def new
    end
  
    def create
      @item = Item.find(params[:item_id]) # @item を定義する
      @purchase_record = PurchaseRecord.new(purchase_record_params)
      @purchase_record.user_id = current_user.id
      @purchase_record.item_id = @item.id
    
      if @purchase_record.valid?
        # pay_item
        @purchase_record.save
        # ShippingArea を作成し、データベースに保存する部分も追加する必要があります
        # shipping_area = ShippingArea.create(
          # 必要な発送先情報を設定
        # )
        redirect_to root_path
      else
        render :index
      end
    end
  
  
    private
  
    def purchase_record_params
      params.require(:purchase_record).permit(:postal_code, :prefecture, :city, :address, :building_name,
                                            :phone_number).merge(user_id: current_user.id, item_id: @item.id)
    end
  
    # def pay_item
      # 支払い処理を実装する（実際の支払いゲートウェイを使用するか、テスト用の処理を記述）
    # end
end