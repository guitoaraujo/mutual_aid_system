class Withdraw < ApplicationRecord
  belongs_to :user
  has_many :orders_withdraws
  has_many :orders, through: :orders_withdraws, dependent: :destroy
  
  before_create :set_expiration_date
  
  enum status: [:pending, :hold, :expired, :cancelled, :approved]
  
  private
  
  def set_expiration_date
    self.expires_in = Time.now + 1.day
  end
end
