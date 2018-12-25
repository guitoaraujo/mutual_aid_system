class OrdersConfig
	
	def initialize(order)
		@order = order
	end
	
	def call
		Cicle.create(
			phase: 1,
			status: :active,
			order: @order,
			user: @order.user
		)
		
		Order.create(
			order_type: :system,
			value: calc(@order.value),
			user: @order.user,
			order: @order,
			status: :pending
		)
		
		if !@order.user.user.blank?
			Order.create(
				order_type: :sponsor,
				value: calc(@order.value),
				user: @order.user,
				order: @order,
				status: :pending
			)
		end
	end
	
	private
	
	def calc(value)
		value * 0.1
	end
end