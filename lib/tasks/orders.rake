task :find_orders_default => :environment do
	orders = Order.where(status: :pending).order(created_at: :desc)
	user   = User.where(admin: true).first
	orders.each do |order|
		order.withdraw.create(value: order.value, user: user, status: :pending)
	end
end

task :check_expiration_date => :environment do
	orders = Order.where(status: :pending)
	orders.each do |order|
		if Time.now >= order.expires_in
			order.expired!
			if order.withdraws.any?
				order.withdraws.expired!
			end
		end
	end
end

task :find_orders => :environment do
	orders = Order.where(status: :pending).order(created_at: :desc)
	orders.each do |order|
		withdraw = Withdraw.where(status: :pending, value: order.value).order(created_at: :desc).first
		withdraw.hold!
		OrderWithdraw.create(order: order, withdraw: withdraw)
	end
end

