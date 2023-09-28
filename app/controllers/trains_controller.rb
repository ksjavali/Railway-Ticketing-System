class TrainsController < ApplicationController
  before_action :set_train, only: %i[ show edit update destroy ]

  # GET /trains or /trains.json
  def index
    if params[:search_departure_station].present? && params[:search_termination_station].present?
      @trains = Train.where('departure_station = ? AND termination_station = ?', params[:search_departure_station], params[:search_termination_station])
    elsif params[:search_departure_station].present?
      @trains = Train.where(departure_station: params[:search_departure_station])
    elsif params[:search_termination_station].present?
      @trains = Train.where(termination_station: params[:search_termination_station])  
    else
      @trains = Train.all
    end
  end

  # GET /trains/1 or /trains/1.json
  def show
  end

  # GET /trains/new
  def new
    @train = Train.new
  end

  # GET /trains/1/edit
  def edit
  end

  # POST /trains or /trains.json
  def create
    @train = Train.new(train_params)

    respond_to do |format|
      if @train.save
        format.html { redirect_to train_url(@train), notice: "Train was successfully created." }
        format.json { render :show, status: :created, location: @train }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @train.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trains/1 or /trains/1.json
  def update
    respond_to do |format|
      if @train.update(train_params)
        format.html { redirect_to train_url(@train), notice: "Train was successfully updated." }
        format.json { render :show, status: :ok, location: @train }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @train.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trains/1 or /trains/1.json
  def destroy
    @train.destroy

    respond_to do |format|
      format.html { redirect_to trains_url, notice: "Train was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_train
      @train = Train.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def train_params
      params.require(:train).permit(:train_number, :departure_station, :termination_station, :departure_date, :departure_time, :arrival_date, :arrival_time, :ticket_price, :train_capacity, :seats_left)
    end
end
