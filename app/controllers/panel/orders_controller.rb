class Panel::OrdersController < ApplicationController
	before_action :set_order, only: [:show, :edit, :update, :destroy]
	before_action :status_verification
	
	
	def index
		@orders = Order.where(user: current_user).paginate(:page => params[:page], :per_page => 10)
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
			OrdersConfig.new(@order).call if @order.deposit?
			redirect_to panel_orders_path
		else
			render :new
		end
	end
	
	def update
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
	
	def status_verification
		redirect_to edit_user_registration_path if current_user.blocked?
	end
	
	def set_order
		@order = Order.find(params[:id])
	end
	
	def order_params
		params.require(:order).permit(:order_type, :value).merge(user: current_user, status: :pending)
	end
end