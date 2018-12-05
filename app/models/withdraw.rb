class Withdraw < ApplicationRecord
  belongs_to :user
  
  before_create :set_expiration_date
  
  enum status: [:pending, :hold, :expired, :cancelled, :approved]
  
  private
  
  def set_expiration_date
    self.expires_in = Time.now + 2.days
  end
end
