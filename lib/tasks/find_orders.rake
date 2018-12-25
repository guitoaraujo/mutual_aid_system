task :find_orders => :environment do
	
	orders = Order.where(status: :pending).order(created_at: :desc)
	user   = User.where(admin: true).first
	orders.each do |order|
		order.withdraw.create(value: order.value, user: user, status: :pending)
	end

end

# task :abc => :environment do
# 	Teste.create
# end