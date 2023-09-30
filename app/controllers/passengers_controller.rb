class PassengersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  before_action :set_passenger, only: %i[ show edit update destroy ]

  # GET /passengers or /passengers.json
  def index
    if admin_user
      @passengers = Passenger.all
    else
      redirect_to root_url
    end
  end

  # GET /passengers/1 or /passengers/1.json
  def show
  end

  # GET /passengers/new
  def new
    if admin_user || !logged_in?
      @passenger = Passenger.new
    else
      redirect_to root_url
    end


  end

  # GET /passengers/1/edit
  def edit
  end

  # POST /passengers or /passengers.json
  def create
    @passenger = Passenger.new(passenger_params)

    respond_to do |format|
      if @passenger.save
        format.html { redirect_to passenger_url(@passenger), notice: "Passenger was successfully created." }
        format.json { render :show, status: :created, location: @passenger }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @passenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /passengers/1 or /passengers/1.json
  def update
    respond_to do |format|
      if @passenger.update(passenger_params)
        format.html { redirect_to passenger_url(@passenger), notice: "Passenger was successfully updated." }
        format.json { render :show, status: :ok, location: @passenger }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @passenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /passengers/1 or /passengers/1.json
  def destroy
    session[:passenger_id]=nil
    @passenger.destroy
    
    respond_to do |format|
      format.html { redirect_to root_url, notice: "Passenger was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_passenger
      @passenger = Passenger.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def passenger_params
      params.require(:passenger).permit(:name, :email, :password, :phone_number, :address, :credit_number)
    end
end
