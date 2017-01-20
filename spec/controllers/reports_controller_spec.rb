require 'rails_helper'

RSpec.describe ReportsController, type: :controller do


  describe "GET #index" do
    login_user

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    login_user

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    login_user

    it "returns http success" do
      get :show, id: 1
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    login_user

    it "returns http success" do
      get :edit, id: 1
      expect(response).to have_http_status(:success)
    end
  end

end
