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

      it 'passwordが英字のみのパスワードでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'passwordが数字のみのパスワードでは登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'passwordが全角文字を含むパスワードでは登録できない' do
        @user.password = 'ああああああ'
        @user.password_confirmation = 'ああああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'お名前(全角)は、名字が空では登録できない' do
        @user.last_name_full_width = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name full width can't be blank")
      end

      it 'お名前(全角)は、名前が空では登録できない' do
        @user.first_name_full_width = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name full width can't be blank")
      end

      it '名字(全角)は、全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
        @user.last_name_full_width = 'Yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name full width is invalid. Input full-width characters")
      end

      it '名前(全角)は、全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
        @user.first_name_full_width = 'Taro'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name full width is invalid. Input full-width characters")
      end

      it 'お名前カナ(全角)は、名字が空では登録できない' do
        @user.last_name_full_width_katakana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name full width katakana can't be blank")
      end

      it 'お名前カナ(全角)は、名前が空では登録できない' do
        @user.first_name_full_width_katakana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name full width katakana can't be blank")
      end

      it '名字カナ(全角)は、全角（カタカナ）でなければ登録できない' do
        @user.last_name_full_width_katakana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name full width katakana is invalid. Input full-width katakana characters")
      end
      
      it 'お名前カナ(全角)は、全角（カタカナ）でなければ登録できない' do
        @user.first_name_full_width_katakana = 'たろう' 
        @user.valid?
        expect(@user.errors.full_messages).to include("First name full width katakana is invalid. Input full-width katakana characters")
      end

      it '生年月日が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
