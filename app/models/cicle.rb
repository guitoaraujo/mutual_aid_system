class Cicle < ApplicationRecord
  belongs_to :order
  belongs_to :user
  
  before_create :set_complete_date

  enum status: [:active, :hold, :cancelled, :finished]
  
  def set_complete_date
    self.complete_date = Time.now + 7.days
  end
end
