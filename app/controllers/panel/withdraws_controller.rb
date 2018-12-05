class Panel::WithdrawsController < ApplicationController
	before_action :set_withdraw, only: [:destroy]
	
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
end