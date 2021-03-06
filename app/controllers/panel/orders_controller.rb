class Panel::OrdersController < ApplicationController
	before_action :set_order, only: [:destroy]
	before_action :cicles_limit, only: [:new, :create]
	
	def index
		@orders = Order.where(user: current_user).paginate(:page => params[:page], :per_page => 10)
	end
	
	def new
		@order = Order.new
	end
	
	def create
		@order = Order.new(order_params)
		if @order.save
			OrdersConfig.new(@order).call
			redirect_to panel_orders_path
		else
			render :new
		end
	end
	
	def destroy
		@order.destroy
		redirect_to panel_orders_path, notice: 'Pagamento cancelado!'
	end
	
	def validate_order
		order              = Order.find(params[:order_id])
		mibank_transaction = params[:code]
		
		if !order.pending?
			render :index, notice: 'Esta ordem não está mais pendente.'
		else
			if OrdersValidation.new(mibank_transaction, params[:order_id]).call
				#current_user.update_attribute(wallet: current.user.wallet + order.value)
				redirect_to panel_orders_path, notice: 'Pagamento aprovado!'
			else
				redirect_to panel_orders_path, notice: 'Erro. Verifique os dados antes de enviar.'
			end
		end
	end
	
	private
	
	def set_order
		@order = Order.find(params[:id])
	end
	
	def cicles_limit
		cicles = current_user.cicles.where(status: :active).count
		redirect_to panel_orders_path, notice: 'Erro. Você não pode ter mais de 5 ciclos ativos ao mesmo tempo.' if cicles >= 5
	end
	
	def order_params
		params.require(:order).permit(:value).merge(user: current_user, order_type: :deposit, status: :pending)
	end
end