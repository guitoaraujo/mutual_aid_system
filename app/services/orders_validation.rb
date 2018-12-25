class OrdersValidation
	
	def initialize(mibank_transaction, order_id)
		@mibank_transaction   = mibank_transaction
		@order                = Order.find(order_id)
		@key                  = '{8599607B-53C6-418D-8AB7-5A632AB03446}'
	end
	
	def call
		if transaction_exists?
			return false
		else
			see_transaction
		end
	end
	
	private
	
	def transaction_exists?
		Order.all.map(&:mibank_transaction).include?(@mibank_transaction)
	end
	
	def see_transaction
		response = HTTParty.get("https://api.mibank.solutions/api/conta/transacao?chave_api=#{@key}&transacao=#{@mibank_transaction}")
		
		if response['valor'] == @order.value && response['tipo'] == 'debito'
			@order.approved!
			@order.mibank_transaction = @mibank_transaction
			@order.save
		else
			false
		end
	end
end