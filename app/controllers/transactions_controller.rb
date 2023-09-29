class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]

  # GET /transactions or /transactions.json
  def index
    if admin_user
      if admin_user.id != nil
        @transactions = Transaction.all
      end
    end
    if current_passenger
      if current_passenger.id != nil
        @transactions = Transaction.where(passenger_id: current_passenger.id)
      else
        @transactions = Transaction.all
      end
    end
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    if @train.nil?
      @train = Train.find(params[:train_id])
    end
    if current_passenger.credit_number != nil
      @credit_number = current_passenger.credit_number
    end
    if current_passenger.address != nil
      @address = current_passenger.address
    end
    if current_passenger.phone_number != nil
      @phone_number = current_passenger.phone_number
    end
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params).lock!("FOR UPDATE NOWAIT")
    @transaction.transaction_number = Array.new(10){[*"A".."Z", *"0".."9"].sample}.join
    @train = Train.find(params[:transaction]["train_id"])
    @transaction.passenger_id = current_passenger.id
    @transaction.train_id = @train.id

    respond_to do |format|
      if @transaction.save
        @train.seats_left = @train.seats_left - 1
        @train.save!
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:transaction_number, :credit_number, :ticket_price, :address, :phone_number)
    end
end
