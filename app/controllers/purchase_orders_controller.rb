class PurchaseOrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    # @order = PurchaseOrder.new
    @order = OrderAddress.new
  end

  def create
    # binding.pry
    @item = Item.find(params[:item_id])
    binding.pry
    # @order = PurchaseOrder.new(order_params)
    @order = OrderAddress.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.permit(:token, :post_code, :prefecture_id, :city_town, :street_number, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
