class Panel::WelcomeController < ApplicationController
  def index
    @cicles = Cicle.where(user: current_user).paginate(:page => params[:page], :per_page => 10)
  end
end
