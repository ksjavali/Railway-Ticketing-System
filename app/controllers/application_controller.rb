class ApplicationController < ActionController::Base
  include ApplicationHelper
  helper_method :current_passenger
  #helper_method :current_order
  helper_method :admin_user
  helper_method :logged_in?
  before_action :authorized

  def current_passenger
    if session[:passenger_id]
      @current_passenger ||= Passenger.find(session[:passenger_id])
    else
      @current_passenger = nil
    end
  end

  def admin_user
    if session[:admin_id]
      @admin_user ||= Admin.find(session[:admin_id])
    else
      @admin_user = nil
    end
  end

  def logged_in?
     !current_passenger.nil? or !admin_user.nil?
  end
  def authorized
    redirect_to root_path unless logged_in?
  end

  # def current_order
  #   if !session[:order_id].nil?
  #     Order.find(session[:order_id])
  #   else
  #     Order.new
  #   end
  #end
end
