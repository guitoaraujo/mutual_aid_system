module ApplicationHelper
	def order_types
		Order.order_types.keys.map { |type| [type.humanize, type] }
	end
end
