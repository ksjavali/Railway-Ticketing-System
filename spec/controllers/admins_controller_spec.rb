require 'rails_helper'

RSpec.describe AdminsController, type: :controller do

    let(:valid_attributes) {
        { name: 'Admin_test', email: 'testadmin@gmail.com', password: 'admin_password',phone_number:1111111111,address:'admin_address',credit_number:1234123412341234 }
    }
    
    let(:invalid_attributes) {
        { name: 'Admin_test',email: 'admin_email', password: 'admin_password' ,phone_number:'111111' , address:'admin_address',credit_number:'1234'}
    }

    describe "GET #index" do
        it "redirects to root_url" do
        get :index
        expect(response).to redirect_to(root_url)
        end
    end

    describe "GET #show" do
        let(:admin) { Admin.create!(valid_attributes) }

        context "not logged in" do
            it "redirects to root_url" do
                get :show, params: { id: admin.to_param }
                expect(response).to redirect_to(root_url)
            end
        end

        context "logged in" do
            before { allow(controller).to receive(:admin_user).and_return(admin) }

            it "renders the show view" do
                get :show, params: { id: admin.to_param }
                expect(response).to render_template(:show)
            end
        end
    end

    describe "GET #new" do
        it "redirects to root_url" do
            get :new
            expect(response).to redirect_to(root_url)
        end
    end

    describe "GET #edit" do
        let(:admin) { Admin.create!(valid_attributes) }

        context "not logged in" do
            it "redirects to root_url" do
                get :edit, params: { id: admin.to_param }
                expect(response).to redirect_to(root_url)
            end
        end

        context "logged in" do
            before { allow(controller).to receive(:admin_user).and_return(admin) }

            it "renders the edit view" do
                get :edit, params: { id: admin.to_param }
                expect(response).to render_template(:edit)
            end
        end
    end


end