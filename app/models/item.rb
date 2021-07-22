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
  with_options numericality: { other_than: 1 , message: "can't be blank" } do
    validates :category_id
    validates :sales_status_id
    validates :sales_status_id
    validates :prefecture_id
    validates :delivery_date_id
  end
  
  belongs_to :user
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :category
    belongs_to :sales_status
    belongs_to :shipping_fee_status
    belongs_to :prefecture
    belongs_to :delivery_date
end
