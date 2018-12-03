class Panel::OrdersController < ApplicationController
	before_action :set_order, only: [:show, :edit, :update, :destroy]
	
	
	def index
		@orders = Order.all
	end
	
	def new
		@order = Order.new
	end
	
	def edit
	end
	
	def show
	
	end
	
	def create
		@order = Order.new(order_params)
		if @order.save
			operations::orders.call(@order)
			redirect_to panel_orders_path
		else
			render 'new'
		end
	end
	
	def update
	end
	
	def destroy
	end
	
	private
	
	def set_order
		@order = Order.find(params[:id])
	end
	
	def order_params
		params.require(:order).permit(:order_type, :value).merge(user: current_user, status: 1)
	end
end