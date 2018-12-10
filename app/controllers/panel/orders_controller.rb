class Panel::OrdersController < ApplicationController
	before_action :set_order, only: [:destroy]
	
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
	end
	
	def validate_order
		order              = Order.find(params[:order_id])
		mibank_transaction = params[:code]
		
		if !order.pending?
			render :index # retornar status como notice flash
		else
			if OrdersValidation.new(mibank_transaction, params[:order_id]).call
				redirect_to panel_orders_path, notice: 'Order was approved!'
			else
				redirect_to panel_orders_path, notice: 'Error, check the data before send.'
			end
		end
	end
	
	private
	
	def set_order
		@order = Order.find(params[:id])
	end
	
	def order_params
		params.require(:order).permit(:value).merge(user: current_user, order_type: :deposit, status: :pending)
	end
end