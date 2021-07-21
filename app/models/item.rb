class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :info
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :delivery_date_id
    validates :price
  end

  belongs_to :user

end
