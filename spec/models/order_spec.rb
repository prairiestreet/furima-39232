require 'rails_helper'

RSpec.describe Order, type: :model do
 before do
  @user = FactoryBot.create(:user)
  @item = FactoryBot.create(:item)
  @order = FactoryBot.build(:order, user_id: @user.id, item_id: @item.id, address: "テスト住所")
  end

  describe '購入情報と発送先情報を保存' do

    context '内容に問題ない場合' do
      it "token含めて全ての情報があれば登録できる" do
       expect(@order).to be_valid
      end

      it "建物名は空でも登録できる" do
        @order.building_name = ''
        expect(@order).to be_valid
      end
    end

    context '内容に問題がある場合' do

      it "郵便番号が空では登録できない" do
        @order.postal_code = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code can't be blank")
      end

      it "郵便番号が「3桁ハイフン4桁」の半角文字列でないと登録できない" do
        @order.postal_code = '11-2222'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

            
      it "都道府県が空では登録できない" do
        @order.prefecture = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Prefecture can't be blank")
      end
      
      it "都道府県の情報が「---」では登録できない" do
        @order.prefecture = 1
        @order.valid?
        expect(@order.errors.full_messages).to include("Prefecture can't be blank")
      end
      
      it "市区町村が空では登録できない" do
        @order.city = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("City can't be blank")
      end
      
      it "番地が空では登録できない" do
        @order.address = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Address can't be blank")
      end
      
      it "電話番号が空では登録できない" do
        @order.phone_number = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number can't be blank")
      end
      
      it "電話番号は10桁以上でないと登録できない" do
        @order.phone_number = '123456789'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number must be 10 digits or 11 digits number, not full width')
      end

      it "電話番号は11桁以内でないと登録できない" do
        @order.phone_number = '123456789012'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number must be 10 digits or 11 digits number, not full width')
      end
      
      it "電話番号は半角数値のみでないと登録できない" do
        @order.phone_number = '123-456-7890'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number must be 10 digits or 11 digits number, not full width')
      end
      
      it 'userが紐づいていなければ場合は購入できない' do
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐づいていなければ場合は購入できない' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Item can't be blank")
      end

      it "tokenが空では登録できないこと" do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end