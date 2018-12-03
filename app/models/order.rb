class Order < ApplicationRecord
  belongs_to :user
  belongs_to :order, optional: true
  has_many :orders

  enum status: [:pending, :approved, :canceled]
  enum order_type: [:deposit, :withdraw, :system, :sponsor]
end
