require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'サインアップ' do
    before do
      @user = FactoryBot.build(:user)
    end

    context 'サインアップできるとき' do
      it '必須情報が全て入力されていれば登録できる' do
        expect(@user).to be_valid
      end

      it '苗字と名前が全角漢字であれば登録できる' do
        @user.family_name = '東京'
        @user.first_name = '太郎'
        expect(@user).to be_valid
      end

      it '苗字と名前が全角ひらがなであれば登録できる' do
        @user.family_name = 'とうきょう'
        @user.first_name = 'たろう'
        expect(@user).to be_valid
      end

      it '苗字と名前が全角カタカナであれば登録できる' do
        @user.family_name = 'トウキョウ'
        @user.first_name = 'タロウ'
        expect(@user).to be_valid
      end

      it '苗字と名前のふりがなが全角カタカナであれば登録できる' do
        @user.family_name_kana = 'トウキョウ'
        @user.first_name_kana = 'タロウ'
        expect(@user).to be_valid
      end
    end

    context 'サインアップできないとき' do
      it 'ニックネームが空の場合は登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空の場合は登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'パスワードが空の場合は登録できない' do
        @user.password = nil
        @user.password_confirmation = 'test01'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワード(確認)が空の場合は登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '苗字が空の場合は登録できない' do
        @user.family_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end

      it '名前が空の場合は登録できない' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it '苗字の振仮名が空の場合は登録できない' do
        @user.family_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end

      it '名前の振仮名が空の場合は登録できない' do
        @user.first_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it '生年月日が空の場合は登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      it 'メールアドレスに@が含まれない場合は登録できない' do
        @user.email = 'test.example.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'メールアドレスが重複している場合は登録できない' do
        @user.save
        @user2 = FactoryBot.build(:user, email: @user.email)
        @user2.valid?
        expect(@user2.errors.full_messages).to include('Email has already been taken')
      end

      it 'パスワードが5文字以下の場合は登録できない' do
        @user.password = 'test0'
        @user.password_confirmation = 'test0'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードが半角英字のみの場合は登録できない' do
        @user.password = 'testtest'
        @user.password_confirmation = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password 半角英数字のみ及び英字、数字の両方が必要です')
      end

      it 'パスワードが半角数字のみの場合は登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password 半角英数字のみ及び英字、数字の両方が必要です')
      end

      it 'パスワードが半角英数字以外の場合は登録できない' do
        @user.password = 'テストパスワード'
        @user.password_confirmation = 'テストパスワード'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password 半角英数字のみ及び英字、数字の両方が必要です')
      end

      it '苗字が半角の場合は登録できない' do
        @user.family_name = 'Tokyo'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name 全角文字を使用してください')
      end

      it '名前が半角の場合は登録できない' do
        @user.first_name = 'Taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角文字を使用してください')
      end

      it '苗字の振仮名がカタカナ以外の場合は登録できない' do
        @user.family_name_kana = 'とうきょう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana 全角カタカナを使用してください')
      end

      it '名前の振仮名がカタカナ以外の場合は登録できない' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana 全角カタカナを使用してください')
      end
    end
  end
end
