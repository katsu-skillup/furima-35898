require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  before do
    item = FactoryBot.create(:item)
    user = FactoryBot.create(:user)
    @order_delivery = FactoryBot.build(:order_delivery, user_id: user.id, item_id: item.id)
    sleep(1)
  end
  
  describe '商品の購入' do
    context '購入情報が保存できる場合' do
      it 'postal_code,prefecture_id,city,address,building,phone_numberがあれば保存できる' do
        expect(@order_delivery).to be_valid
      end
      it 'buildingが空でも保存できる' do
        @order_delivery.building = ''
        expect(@order_delivery).to be_valid
      end
    end

    context '購入情報が保存できない場合' do
      it 'tokenが空だと保存ができない' do
        @order_delivery.token = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include "Token can't be blank"
      end 
      it 'postal_codeが空だと保存できない' do
        @order_delivery.postal_code = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include "Postal code can't be blank"
      end
      it 'postal_codeが全角数字とハイフンを含むと保存できない' do
        @order_delivery.postal_code = '１２３-４５６７'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include 'Postal code is invalid. Enter it as follows(e.g. 123-4567)'
      end
      it 'postal_codeが半角数字のみでは保存できない' do
        @order_delivery.postal_code = '12345678'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include 'Postal code is invalid. Enter it as follows(e.g. 123-4567)'
      end
      it 'prefecture_idが空では保存できない' do
        @order_delivery.prefecture_id = 1
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include "Prefecture can't be blank"
      end
      it 'cityが空だと保存できない' do
        @order_delivery.city = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include "City can't be blank"   
      end
      it 'addressが空だと保存できない' do
        @order_delivery.address = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include "Address can't be blank"   
      end
      it 'phone_numberが空だと保存できない' do  
        @order_delivery.phone_number = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include "Phone number can't be blank"   
      end
      it 'phone_numberが10桁未満だと保存できない' do
        @order_delivery.phone_number = '090123456'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include 'Phone number is too short'   
      end
      it 'phone_numberに全角数値は保存できない' do
        @order_delivery.phone_number = '０９０１２３４５６７８'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include 'Phone number is invalid. Input only number'
      end
      it 'phone_numberに文字列は保存できない' do
        @order_delivery.phone_number = 'あいうえおabcde'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include 'Phone number is invalid. Input only number' 
      end
    end
  end
end
