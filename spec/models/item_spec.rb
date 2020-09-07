require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品の出品（登録）' do
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('public/images/test_image.png')
    end

    context '商品が出品(登録)できるとき' do
      it '必要情報が全て入力されている' do
        expect(@item).to be_valid
      end
    end

    context '商品が出品(登録)できないとき' do
      it '商品名が空欄の場合は登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品説明が空欄の場合は出品(登録)できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーが選択されていない場合は出品(登録)できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Category is not selected')
      end

      it '商品の状態が選択されていない場合は出品(登録)できない' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition is not selected')
      end

      it '配送料の負担が選択されていない場合は出品(登録)できない' do
        @item.delivery_charge_type_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery charge type is not selected')
      end

      it '配送元の地域が選択されていない場合は出品(登録)できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture is not selected')
      end

      it '発送までの日数が選択されていない場合は出品(登録)できない' do
        @item.delivery_schedule_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery schedule is not selected')
      end

      it '価格が空欄の場合は出品(登録)できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が半角数字以外で入力された場合は出品(登録)できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price should be numbers')
      end

      it '価格が299以下の場合は出品(登録)できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of price range')
      end

      it '価格が10,000,000以上の場合は出品(登録)できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of price range')
      end
    end
  end
end
