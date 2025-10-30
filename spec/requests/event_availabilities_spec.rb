require 'rails_helper'

RSpec.describe "EventAvailabilities", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/event_availabilities/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/event_availabilities/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/event_availabilities/update"
      expect(response).to have_http_status(:success)
    end
  end

end
