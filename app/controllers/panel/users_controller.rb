class Panel::UsersController < ApplicationController
	skip_before_action :authenticate_user!
	
	def new
		if params[:uid]
			@sponsor  = User.find(params[:uid])
		end
		@user       = User.new
	end
	
	def create
		binding.pry
		@user  = User.new(users_params)
		if @user.save
			redirect_to new_user_session_path notice: 'Cadastro realizado com sucesso, realize o login!'
		else
			render :new, notice: 'Erro ao cadastro, verifique os dados e tenta novamente.'
		end
	end
	
	private
	
	def users_params
		params.require(:user).permit(:user_id, :name, :cpf, :phone, :email, :mibank, :country, :zipcode, :password, :password_confirmation)
	end
end