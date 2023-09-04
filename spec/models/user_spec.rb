require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'nameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが半角英数字混合での入力が必須であること' do
        @user.password = 'test1'
        @user.password_confirmation = 'test1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'お名前(全角)は、名字がそれぞれ必須であること' do
        @user.last_name_full_width = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name full width can't be blank")
      end

      it 'お名前(全角)は、名前がそれぞれ必須であること' do
        @user.first_name_full_width = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name full width can't be blank")
      end

      it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.last_name_full_width = '山田'
        @user.first_name_full_width = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to be_empty
      end

      it 'お名前カナ(全角)は、名字がそれぞれ必須であること' do
        @user.last_name_full_width_katakana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name full width katakana can't be blank")
      end

      it 'お名前カナ(全角)は、名前がそれぞれ必須であること' do
        @user.first_name_full_width_katakana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name full width katakana can't be blank")
      end

      it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
        @user.last_name_full_width_katakana = 'ヤマダ'  # 例：全角カタカナ
        @user.first_name_full_width_katakana = 'タロウ'  # 例：全角カタカナ
        @user.valid?
        expect(@user.errors.full_messages).to be_empty
      end

      it '生年月日が必須であること' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
