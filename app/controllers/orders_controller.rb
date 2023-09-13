class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    @order = Order.new
  end

  def new
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      # pay_item
      @order.save
      redirect_to root_path
    else
      render :index
    end
  end


  private

  def order_params
    params.require(:order).permit(:postal_code, :prefecture, :city, :address, :building_name, :phone_number)
          .merge(user_id: current_user.id, item_id: @item.id)
  end

def set_item
  @item = Item.find(params[:item_id])
end

  # def pay_item
    # 支払い処理を実装する（実際の支払いゲートウェイを使用するか、テスト用の処理を記述）
  # end
end
