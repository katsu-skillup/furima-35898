class OrderDelivery
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :order_id

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows(e.g. 123-4567)" }
    validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank" }
    validates :city
    validates :address
    validates :phone_number, length: { in: 10..11, message: "is too short" } ,format: {with: /\A[0-9]\d{10,11}\z/, message: "is invalid. Input only number" }
  end
 
  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Delivery.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number, order_id: order.id)
  end
end