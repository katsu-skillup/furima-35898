class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :info
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :delivery_date_id
     with_options inclusion: {in: 300..999999, message: 'is out of setting range' } ,format: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width characters'} do
      validates :price
     end
  end

  belongs_to :user

end
