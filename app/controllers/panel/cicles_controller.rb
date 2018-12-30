class Panel::CiclesController < ApplicationController
  def index
    @cicles = Cicle.where(user: current_user).paginate(:page => params[:page], :per_page => 10)
  end
  
  def renew
    cicle = Cicle.find(params[:cicle_id])
    cicle.order.create(value: cicle.value, user: cicle.user, status: :pending)
    redirect_to panel_cicles_index notice: 'Recompromisso realizado!'
  end
end
