class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    # @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:item).permit(:content, :image).merge(user_id: current_user.id)
  end

  def item_params
    params.require(:item).permit(:name, :image, :explanation, :price, :category_id, :status_id, :shipping_fee_id, :prefecture_id,
                                 :preparation_day_id).merge(user_id: current_user.id)
  end
end
