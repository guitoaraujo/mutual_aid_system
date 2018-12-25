class Order < ApplicationRecord
  belongs_to :user
  belongs_to :order, optional: true
  has_many :cicles
  has_many :orders, dependent: :destroy
  has_many :orders_withdraws
  has_many :withdraws, through: :orders_withdraws, dependent: :destroy
  
  validate :value_limits
  
  before_create :set_expiration_date

  enum status: [:pending, :hold, :expired, :cancelled, :approved]
  enum order_type: [:deposit, :system, :sponsor]
  
  private
  
  def set_expiration_date
    self.expires_in = Time.now + 2.days
  end

  def value_limits
    if self.deposit?
      if self.value > 5000
        errors.add(:value, 'cannot be above R$ 5000')
      elsif self.value < 100
        errors.add(:value, 'cannot be below R$ 100')
      elsif !self.value.%(100).zero?
        errors.add(:value, 'must be multiple of 100')
      end
    end
  end
end
