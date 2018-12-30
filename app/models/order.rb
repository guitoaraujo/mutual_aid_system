class Order < ApplicationRecord
  belongs_to :user
  belongs_to :order, optional: true
  has_many :cicles, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :orders_withdraws
  has_many :withdraws, through: :orders_withdraws, dependent: :destroy
  
  validate :value_limits
  
  before_create :set_expiration_date

  enum status: [ :pending, :approved, :hold, :cancelled, :expired ]
  enum order_type: [ :deposit, :system, :sponsor ]
  
  private
  
  def set_expiration_date
    self.expires_in = Time.now + 1.day
  end

  def value_limits
    if self.deposit?
      if self.value > 3000
        errors.add(:value, 'cannot be above R$ 3000')
      elsif self.value < 50
        errors.add(:value, 'cannot be below R$ 50')
      elsif !self.value.%(50).zero?
        errors.add(:value, 'must be multiple of 50')
      end
    end
  end
end
