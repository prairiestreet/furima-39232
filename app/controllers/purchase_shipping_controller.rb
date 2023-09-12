class PurchaseShippingController < ApplicationController
  before_action :authenticate_user!

  def index
    @purchase_shipping = PurchaseShipping.new
  end

  def new
  end

  def create
    @purchase_shipping = PurchaseShipping.new(purchase_record_params)
    if @purchase_shipping.valid?
      pay_item
      @purchase_shipping.save
      return redirect_to root_path
    else
      render :index
    end
  end


  private

  def purchase_record_params
    params.require(:purchase_shipping).permit(:postal_code, :prefecture, :city, :address, :building_name,
                                          :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end


end
