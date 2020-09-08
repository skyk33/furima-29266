class ItemsController < ApplicationController
  before_action :redirect_to_root, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
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

  def show
  end

  def edit
    redirect_to action: :index unless current_user.id == @item.user.id
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
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
    redirect_to action: :index unless user_signed_in?
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
