require 'bcrypt'
class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  def new
    if logged_in?
      redirect_to root_url
    end

  end
  def create
      passenger = Passenger.find_by_email(params[:email])
      if passenger && passenger.authenticate(params[:password]) && !passenger.is_admin
        session[:passenger_id] = passenger.id
        redirect_to root_url, notice: "Logged in!"
      else
        flash.now[:alert] = "Email or password is invalid"
        render "new"
      end
  end
  def destroy
    session[:passenger_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end