require 'rails_helper'

RSpec.describe Item, type: :model do
    before do
      @item = FactoryBot.build(:item)
    end
   
  describe '商品の保存' do
    context '商品が保存できる場合' do
      it 'image、name、info、category_id、sales_status_id、shipping_fee_status_id、prefecture_id、delivery_date_id、priceがあれば商品は保存される' do
        expect(@item).to be_valid
      end
    end
    context '商品が保存できない場合' do
      it 'imageが空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
        
      it 'nameが空では保存できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Name can't be blank"
      end
        
      it 'infoが空では保存できない' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Info can't be blank"
      end
        
      it 'category_idが空では保存できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end
        
      it 'sales_status_idが空では保存できない' do
        @item.sales_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Sales status can't be blank"
      end
        
      it 'shipping_fee_idが空では保存できない' do
        @item.shipping_fee_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipping fee status can't be blank"
      end
        
      it 'prefecture_idが空では保存できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end
        
      it 'delivery_date_idが空では保存できない' do
        @item.delivery_date_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Delivery date can't be blank"
      end

      it 'priceが空では保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end

      it 'priceが全角数値では保存できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is invalid. Input half-width characters'
      end
      
      it 'priceが300未満では保存できない' do
        @item.price = '200'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is out of setting range'
      end

      it 'priceが10000000以上では保存できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is out of setting range'
      end
        
      it 'ユーザーが紐づいていなければ保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include 'User must exist'
      end
    end
  end
end
