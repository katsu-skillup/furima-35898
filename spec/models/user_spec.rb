require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  
  describe 'ユーザー新規登録' do
    context '新規登録できる時' do
      it 'nickname、email、password、password_confirmation、last_name、first_name、last_name_kana、first_name_kanaおよびbirthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'passwordとpassword_confirmationが英数混合6文字以上であれば登録できる' do
        @user.password = '000aaa'
        @user.password_confirmation = '000aaa'
        expect(@user).to be_valid
      end

      it 'last_nameが全角漢字であれば登録できる' do
        @user.last_name = '試験'
        expect(@user).to be_valid
      end
      
      it 'last_nameが全角かなであれば登録できる' do
        @user.last_name = 'しけん'
        expect(@user).to be_valid
      end

      it 'last_nameが全角カナであれば登録できる' do
        @user.last_name = 'シケン'
        expect(@user).to be_valid
      end

      it 'first_nameが全角漢字であれば登録できる' do
        @user.first_name = '試験'
        expect(@user).to be_valid
      end
      
      it 'firdt_nameが全角かなであれば登録できる' do
        @user.first_name = 'しけん'
        expect(@user).to be_valid
      end

      it 'first_nameが全角カナであれば登録できる' do
        @user.first_name = 'シケン'
        expect(@user).to be_valid
      end

      it 'last_name_kanaが全角カナであれば登録できる' do
        @user.last_name_kana = 'シケン'
      end

      it 'first_name_kanaが全角カナであれば登録できる' do
        @user.first_name_kana= 'シケン'
      end     
    end

    context '新規登録できない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end

      it '同じemailは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailには＠が含まれていなければならない' do
        @user.email = 'testtest.com'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
   
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end

      it 'passwordは5文字以下であれば登録できない' do
        @user.password = '111aa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end

      it 'passwordは半角英数字以外であれば登録できない' do
        @user.password = 'パスワード設定'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid. Include both letters and numbers'
      end
      
      it 'passwordが存在しても、password_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end

      it 'last_nameには全角（漢字、かな、カナ)以外登録できない' do
        @user.last_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name is invalid. Input full-width characters'
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end

      it 'first_nameには全角（漢字、かな、カナ)以外登録できない' do
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name is invalid. Input full-width characters'
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana can't be blank"
      end

      it 'last_name_kanaには全角カナ以外登録できない' do
        @user.last_name_kana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name kana is invalid. Input full-width katakana characters'
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana can't be blank"
      end

      it 'first_name_kanaには全角カナ以外登録できない' do
        @user.first_name_kana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name kana is invalid. Input full-width katakana characters'
      end

      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
    end
  end
end
