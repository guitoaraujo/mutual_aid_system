class Operations::Orders
	def call(order)
		Order.create(
			order_type: 2,
			value: calc(order.value),
			user: order.user,
			order: order,
			status: 0
		)
		
		if order.user.user != nil
			Order.create(
				order_type: 3,
				value: calc(order.value),
				user: order.user,
				order: order,
				status: 0
			)
		end
	end
	
	private
	
	def calc(value)
		value * 01
	end
end