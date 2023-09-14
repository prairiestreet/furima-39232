require 'rails_helper'

RSpec.describe PurchaseRecord, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user: @user) # Userと関連付け
    @purchase_record = FactoryBot.build(:purchase_record, user: @user, item: @item)
  end

  describe '購入情報と発送先情報を保存' do
    context '内容に問題ない場合' do
      it '全ての情報があれば登録できる' do
        expect(@purchase_record).to be_valid
      end

      it '建物名は空でも登録できる' do
        @purchase_record.building_name = ''
        expect(@purchase_record).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空では登録できない' do
        @purchase_record.postal_code = ''
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号が「3桁ハイフン4桁」の半角文字列でないと登録できない' do
        @purchase_record.postal_code = '11-2222'
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it '都道府県が空では登録できない' do
        @purchase_record.prefecture = ''
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '都道府県の情報が「---」では登録できない' do
        @purchase_record.prefecture = 1
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空では登録できない' do
        @purchase_record.city = ''
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では登録できない' do
        @purchase_record.address = ''
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空では登録できない' do
        @purchase_record.phone_number = ''
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号は10桁以上でないと登録できない' do
        @purchase_record.phone_number = '123456789'
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include('Phone number must be 10 digits or 11 digits number, not full width')
      end

      it '電話番号は11桁以内でないと登録できない' do
        @purchase_record.phone_number = '123456789012'
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include('Phone number must be 10 digits or 11 digits number, not full width')
      end

      it '電話番号は半角数値のみでないと登録できない' do
        @purchase_record.phone_number = '123-456-7890'
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include('Phone number must be 10 digits or 11 digits number, not full width')
      end

      it 'userが紐づいていなければ場合は購入できない' do
        @purchase_record.user_id = nil
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐づいていなければ場合は購入できない' do
        @purchase_record.item_id = nil
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
