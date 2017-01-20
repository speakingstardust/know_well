require 'rails_helper'

RSpec.describe ReportsController, type: :controller do


  describe "GET #index" do
    login_user
    let(:report) { create(:report) }

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "correctly display all projects correctly" do
      report

      get :index

      expect(assigns(:reports).count).to eq(1)
    end
  end

  describe "GET #new" do
    login_user

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end


end
