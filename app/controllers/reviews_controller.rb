class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
    @reviews = if params[:train_id].present?
      Review.where(train_id: params[:train_id])
   elsif params[:passenger_id].present?
      Review.where(passenger_id: current_passenger.id)
   elsif params[:search_by_train_number].present?
      Review.joins(:train).select('reviews.*').group('reviews.id').having('train_number = ?',params[:search_by_train_number])
   elsif params[:search_by_user].present?
      Review.joins(:passenger).select('reviews.*').group('reviews.id').having('name= ? ',params[:search_by_user])
    else
     Review.all
   end
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
    @review.train_id = params[:train_id]
    @train = Train.find_by(id: params[:train_id])
    if !admin_user and Date.today < @train.departure_date 
      redirect_to tickets_url, notice:"Not yet travelled"
    end
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    @train = Train.find_by(id: params[:review]["train_id"])
    @count = Review.where(train_id: @train.id).count
    if current_passenger
      @review.passenger_id = current_passenger.id
      @review.train_id = @train.id
    elsif admin_user
        @review.passenger_id = admin_user.id
        @review.train_id = @train.id
    end
    respond_to do |format|
      @train.average_rating = (@train.average_rating* @count + @review.rating)/(Review.where(train_id: @train.id).count+1)
      @train.average_rating = @train.average_rating.round(2)
      # puts "#{Review.where(train_id: @train.id).count} hello hello"
      # puts "#{@train.average_rating} hello hello"
      #@train.average_rating = @train.average_rating/(Review.where(train_id: @train.id).count+1)
      #@train.average_rating = @train.average_rating.round(2)

      if @review.save & @train.save
        format.html { redirect_to review_url(@review), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    @train = Train.find_by(id: params[:review]["train_id"])
    @count = Review.where(train_id: @train.id).count
    respond_to do |format|
      if @review.update(review_params)
        @train.average_rating = (Review.where(train_id: @train.id).sum(:rating).to_f)/(Review.where(train_id: @train.id).count)
        @train.average_rating = @train.average_rating.round(2)
        @train.save
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @train = Train.find_by(id: @review.train_id)
    @count = Review.where(train_id: @train.id).count
    if @count != 1
        @train.average_rating = (@train.average_rating* @count- @review.rating)/(@count - 1)
        @train.average_rating = @train.average_rating.round(2)

        @train.save!
    else
        @train.average_rating = 0
    end
    
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:rating, :feedback, :train_id)
    end
end
