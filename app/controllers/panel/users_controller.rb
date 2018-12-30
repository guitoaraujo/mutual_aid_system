class Panel::UsersController < ApplicationController
	
	def index
		@users = User.where(user: current_user)
		@user  = User.new
	end
	
	def create
		@user  = User.new(users_params)
		if @user.save
			redirect_to panel_users_path notice: 'Cadastro realizado com sucesso.'
		else
			render :index, notice: 'Erro ao cadastro, verifique os dados e tenta novamente.'
		end
	end
	
	private
	
	def users_params
		params.require(:user).permit(:name, :cpf, :phone, :email, :mibank, :country, :zipcode, :password, :password_confirmation)
	end
end