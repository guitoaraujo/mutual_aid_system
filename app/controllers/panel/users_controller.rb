class Panel::UsersController < ApplicationController
	
	def index
		@users = User.where(user: current_user)
		@user  = User.new
	end
	
	def create
		@user  = User.new(users_params)
	end
	
	private
	
	def users_params
		params.require(:user).permit(:name, :cpf, :phone, :email, :mibank, :password, :password_confirmation)
	end
end