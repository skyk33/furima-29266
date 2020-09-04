class ItemsController < ApplicationController
  before_action :redirect_to_root, except: [:index]

  def index
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

  def item_params
    params.require(:item).permit(
      :name, 
      :description, 
      :category_id, 
      :condition_id, 
      :delivery_charge_type_id, 
      :prefecture_id, 
      :delivery_schedule_id,
      :price,
      :image
    ).merge(user_id: current_user.id)
  end

  def redirect_to_root
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
