class Withdraw < ApplicationRecord
  belongs_to :user
  has_many :orders_withdraws
  has_many :orders, through: :orders_withdraws, dependent: :destroy
  
  before_create :value_limit

  enum status: [ :pending, :approved, :hold, :cancelled, :expired ]
  
  private
  
  # def set_expiration_date
  #   self.expires_in = Time.now + 1.day
  # end
  
  def value_limit
    if self.value < 30
      errors.add(:value, 'cannot be below R$ 50')
    elsif self.value > self.wallet
      errors.add(:value, 'cannot exceed your current wallet')
    elsif !self.value.%(50).zero?
      errors.add(:value, 'must be multiple of 50')
    elsif self.value > 5100
      errors.add(:value, 'cannot exceed R$ 5100')
    end
  end
end
