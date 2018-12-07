class OrdersWithdraw < ApplicationRecord
  belongs_to :order
  belongs_to :withdraw
end
