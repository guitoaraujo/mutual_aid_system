module ApplicationHelper
	def order_types
		Order.order_types.keys.map { |type| [type.humanize, type] }
	end
	
	def set_status(status)
		case status
			when 'pending'
				"caralho"
			when 'approved'
				"Aprovado"
			when 'hold'
				"Suspenso"
			when 'cancelled'
				"Cancelado"
			when 'expired'
				"Espirado"
			when 'finished'
				"Finalizado"
			when 'inactive'
				"Inativo"
			when 'active'
				"Ativo"
			else
				"Erro, consulte o admin."
		end
	end
end