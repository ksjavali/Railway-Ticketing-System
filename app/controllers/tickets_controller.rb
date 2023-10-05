class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]

  

  # GET /tickets or /tickets.json
  def index
    if !admin_user
      @tickets = Ticket.where(passenger_id: current_passenger.id)
    elsif params[:search_by_train_number].present?
      @tickets=Ticket.joins(:train).select('tickets.*').group('tickets.id').having('train_number = ?',params[:search_by_train_number])
    else
      @tickets = Ticket.all
    end
  end
  # GET /tickets/1 or /tickets/1.json
  def show
    @train = Train.find_by(id: @ticket.train_id) 
  end

  # GET /tickets/new

  def ticket_book
    @ticket = Ticket.new
    @train = Train.find_by(id: params[:train_id])
    @passengers = Passenger.where(is_admin: false)
  end

  def new
    @ticket = Ticket.new
    if admin_user
      @passengers = Passenger.where(is_admin: false)
    end
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
    @train = Train.find_by(id: @ticket.train_id) 
  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new
    @train = Train.find_by(id: params[:ticket]["train_id"])
    @ticket.confirmation_number = generate_confirmation_number
    @ticket.username = Passenger.find_by(id: current_passenger.id).name

    if current_passenger
      @ticket.passenger_id = current_passenger.id
      @ticket.train_id = @train.id
    elsif admin_user
      @ticket.passenger_id = params[:ticket]["passenger_id"]
      @ticket.train_id = @train.id
    end

    seats = @train.seats_left-1

    respond_to do |format|
      if Time.now() < @train.departure_date && seats>0 && @ticket.save
        @train.seats_left = @train.seats_left - 1
        @train.save
        format.html{ redirect_to tickets_url(@ticket), notice: "Ticket booked successfully. Confirmation number: #{@ticket.confirmation_number}" }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { redirect_to trains_path, notice: "No seats left"}
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def ticket_book_create
    @ticket1 = Ticket.new
    @ticket2 = Ticket.new
    @train = Train.find_by(id: params[:ticket]["train_id"])
    confirmation_number = generate_confirmation_number
    @ticket1.confirmation_number = confirmation_number


    @ticket2.confirmation_number = confirmation_number

    
    @ticket1.passenger_id = current_passenger.id
    @ticket2.passenger_id = params[:ticket]["passenger_id"]
    @ticket1.train_id = @train.id
    @ticket2.train_id = @train.id
    @ticket1.username = Passenger.find_by(id: params[:ticket]["passenger_id"]).name
    @ticket2.username = Passenger.find_by(id: params[:ticket]["passenger_id"]).name

    seats = @train.seats_left-1

    respond_to do |format|
      if seats>0 && @ticket1.save && @ticket2.save
        @train.seats_left = @train.seats_left - 1
        @train.save
        format.html{ redirect_to tickets_url(@ticket1), notice: "Ticket booked successfully. Confirmation number: #{@ticket1.confirmation_number}" }
        format.json { render :show, status: :created, location: @ticket1 }
      else
        format.html { redirect_to trains_path, notice: "No seats left"}
        format.json { render json: @ticket1.errors, status: :unprocessable_entity }
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
    @train = Train.find_by(id: @ticket.train_id)
    
    respond_to do |format|
      if @ticket.delete 
        @train.seats_left = @train.seats_left + 1
        @train.save
        format.html { redirect_to tickets_url, notice: "Ticket was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
     def ticket_params
       params.require(:ticket).permit(:passenger_id,:credit_number,:ticket_price,:address,:phone_number,:train_id)
     end

    #Generate the confirmation number using SecureRandom
    def generate_confirmation_number
      SecureRandom.random_number(900_000) + 100_000
    end
end
