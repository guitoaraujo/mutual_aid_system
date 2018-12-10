class Order < ApplicationRecord
  belongs_to :user
  belongs_to :order, optional: true
  has_many :orders, dependent: :destroy
  has_many :orders_withdraw
  has_many :withdraws, through: :orders_withdraws, dependent: :destroy
  
  before_create :set_expiration_date

  enum status: [:pending, :hold, :expired, :cancelled, :approved]
  enum order_type: [:deposit, :system, :sponsor]
  
  private
  
  def set_expiration_date
    self.expires_in = Time.now + 2.days
  end
end
