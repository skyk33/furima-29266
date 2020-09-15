class PurchaseOrdersController < ApplicationController
  before_action :redirect_sign_in
  before_action :set_item

  def index
    redirect_to root_path if (current_user.id == @item.user.id) || PurchaseOrder.exists?(item_id: @item.id)
    @order = OrderAddress.new
  end

  def create
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
    params.permit(:token, :post_code, :prefecture_id, :city_town, :street_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_sign_in
    redirect_to new_user_session_path unless user_signed_in?
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
