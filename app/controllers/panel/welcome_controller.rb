class Panel::WelcomeController < ApplicationController
  def index
    # @orders = Order.where(order_type: :withdraw).paginate(:page => params[:page], :per_page => 10)
  end
end
