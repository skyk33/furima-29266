require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do
      @order = FactoryBot.build(:order_address)
    end

    context '購入情報が保存できる場合' do
      it '全ての値が全て正しく入力されていれる場合は保存できる' do
        expect(@order).to be_valid
      end

      it 'building_nameが未記入でも保存できる' do
        @order.building_name = ''
        expect(@order).to be_valid
      end
    end

    context '購入情報が保存できない場合' do
      it 'user_idが空の場合は保存できない' do
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空の場合は保存できない' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Item can't be blank")
      end

      it 'tokenが空の場合は保存できない' do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end

      it 'post_codeが空の場合は保存できない' do
        @order.post_code = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Post code can't be blank")
      end

      it 'prefecture_idが0の場合は保存できない' do
        @order.prefecture_id = 0
        @order.valid?
        expect(@order.errors.full_messages).to include('Prefecture is not selected')
      end

      it 'city_townが空の場合は保存できない' do
        @order.city_town = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("City town can't be blank")
      end

      it 'street_numberが空の場合は保存できない' do
        @order.street_number = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Street number can't be blank")
      end

      it 'phone_numberが空の場合は保存できない' do
        @order.phone_number = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'post_codeにハイフンが含まれない場合は保存できない' do
        @order.post_code = '1234567'
        @order.valid?
        expect(@order.errors.full_messages).to include('Post code is invalid. Should be half-width numbers and total 8 characters including hyphen(-)')
      end

      it 'post_codeのハイフンの前が３桁の数字でない場合は保存できない' do
        @order.post_code = '12-4567'
        @order.valid?
        expect(@order.errors.full_messages).to include('Post code is invalid. Should be half-width numbers and total 8 characters including hyphen(-)')
      end

      it 'post_codeのハイフンの後が４桁の数字でない場合は保存できない' do
        @order.post_code = '123-456'
        @order.valid?
        expect(@order.errors.full_messages).to include('Post code is invalid. Should be half-width numbers and total 8 characters including hyphen(-)')
      end

      it 'post_codeが全角数字の場合は保存できない' do
        @order.post_code = '１２３−４５６７'
        @order.valid?
        expect(@order.errors.full_messages).to include('Post code is invalid. Should be half-width numbers and total 8 characters including hyphen(-)')
      end

      it 'phone_numberにハイフンが含まれる場合は保存できない' do
        @order.phone_number = '090-1234-5678'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is invalid. Should be half-width numbers (11 characters). Should not include hypen(-)')
      end

      it 'phone_numberが11桁より少ないの場合は保存できない' do
        @order.phone_number = '0901234567'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is invalid. Should be half-width numbers (11 characters). Should not include hypen(-)')
      end

      it 'phone_numberが11桁より多い場合は保存できない' do
        @order.phone_number = '090123456789'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is invalid. Should be half-width numbers (11 characters). Should not include hypen(-)')
      end

      it 'phone_numberの先頭３桁が090,080,070,050以外の場合は保存できない' do
        @order.phone_number = '06012345678'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is invalid. Should be half-width numbers (11 characters). Should not include hypen(-)')
      end

      it 'phone_numberが全角の場合は保存できない' do
        @order.phone_number = '０９０１２３４５６７８'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is invalid. Should be half-width numbers (11 characters). Should not include hypen(-)')
      end
    end
  end
end
