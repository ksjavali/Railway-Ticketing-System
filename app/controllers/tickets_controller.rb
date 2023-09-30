class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]

  # GET /tickets or /tickets.json
  def index
    @tickets = Ticket.all
  end

  # GET /tickets/1 or /tickets/1.json
  def show
    @train = Train.find_by(id: @ticket.train_id) 
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    if @train.nil?
      begin
        @train = Train.where(id: params[:train_id])[0]
      rescue
        redirect_to trains_path
      end
    end
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new
    @train = Train.find_by(id: params[:ticket]["train_id"])
    @ticket.confirmation_number = generate_confirmation_number
    

    if current_passenger
      @ticket.passenger_id = current_passenger.id
      @ticket.train_id = @train.id
    elsif admin_user
        @ticket.passenger_id = admin_user.id
        @ticket.train_id = @train.id
    end

    if @train.seats_left < 1
      redirect_to trains_path, notice: "No seats available!"
    else
      @train.seats_left = @train.seats_left - 1
    end

    respond_to do |format|
      if @ticket.save & @train.save
        format.html{ redirect_to tickets_url(@ticket), notice: "Ticket booked successfully. Confirmation number: #{@ticket.confirmation_number}" }
        format.json { render :show, status: :created, location: @ticket }
      else
        # redirect_to tickets_path, notice: "Error in creating ticket. Confirmation number: #{@ticket.confirmation_number}"
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url, notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # def ticket_params
    #   params.require(:ticket).permit(:confirmation_number)
    # end

    #Generate the confirmation number using SecureRandom
    def generate_confirmation_number
      SecureRandom.random_number(900_000) + 100_000
    end
end
