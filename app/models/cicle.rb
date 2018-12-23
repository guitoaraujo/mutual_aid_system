class Cicle < ApplicationRecord
  belongs_to :user
  has_many :orders

  enum status: [:phase1, :phase2, :phase3, :phase4, :phase5, :hold, :canceled, :finished]
end
