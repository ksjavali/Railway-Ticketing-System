# spec/controllers/trains_controller_spec.rb

require 'rails_helper'

RSpec.describe TrainsController, type: :controller do
  let(:valid_attributes) {
    {
      train_number: 'T123',
      departure_station: 'Station A',
      termination_station: 'Station B',
      departure_date: Date.tomorrow,
      departure_time: Time.now,
      arrival_date: Date.tomorrow,
      arrival_time: Time.now + 2.hours,
      ticket_price: 10,
      train_capacity: 100,
      seats_left: 100
    }
  }

  let(:invalid_attributes) {
    {
      train_number: '',
      departure_station: 'Station A',
      termination_station: 'Station B',
      departure_date: Date.tomorrow,
      departure_time: Time.now,
      arrival_date: Date.tomorrow,
      arrival_time: Time.now + 2.hours,
      ticket_price: 10,
      train_capacity: 100,
      seats_left: 100
    }
  }

  let(:admin) { create(:admin) }
  let(:train) { create(:train) }

  before do
    allow(controller).to receive(:admin_user).and_return(true) # Stub admin_user method
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: train.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: train.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Train" do
        expect {
          post :create, params: { train: valid_attributes }
        }.to change(Train, :count).by(1)
      end

      it "redirects to the created train" do
        post :create, params: { train: valid_attributes }
        expect(response).to redirect_to(train_url(Train.last))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e., to display the 'new' template)" do
        post :create, params: { train: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          train_number: 'T124',
          departure_station: 'Station X'
        }
      }

      it "updates the requested train" do
        put :update, params: { id: train.to_param, train: new_attributes }
        train.reload
        expect(train.train_number).to eq(new_attributes[:train_number])
        expect(train.departure_station).to eq(new_attributes[:departure_station])
      end

      it "redirects to the train" do
        put :update, params: { id: train.to_param, train: valid_attributes }
        expect(response).to redirect_to(train_url(train))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e., to display the 'edit' template)" do
        put :update, params: { id: train.to_param, train: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested train" do
      train # Create a train record
      expect {
        delete :destroy, params: { id: train.to_param }
      }.to change(Train, :count).by(-1)
    end

    it "redirects to the trains list" do
      delete :destroy, params: { id: train.to_param }
      expect(response).to redirect_to(trains_url)
    end
  end
end
