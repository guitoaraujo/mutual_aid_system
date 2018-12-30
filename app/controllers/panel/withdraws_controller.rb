class Panel::WithdrawsController < ApplicationController
	before_action :set_withdraw, only: [:destroy]
	before_action :can_withdraw?, except: [:index]
	
	def index
		@withdraws = Withdraw.where(user: current_user).paginate(:page => params[:page], :per_page => 10)
	end
	
	def new
		@withdraw = Withdraw.new
	end
	
	def create
		@withdraw = Withdraw.new(withdraws_params)
		if @withdraw.save
		
		else
		
		end
	end
	
	def destroy
	
	end
	
	private
	
	def set_withdraw
		@withdraw = Withdraw.find(params[:id])
	end
	
	def withdraws_params
		params.require(:withdraw).permit(:value).merge(user: current_user, status: :pending)
	end
	
	def can_withdraw?
		if current_user.wallet < 50
			redirect_to panel_orders_path, notice: 'Você ainda não pode pedir ajuda.'
		end
	end
end