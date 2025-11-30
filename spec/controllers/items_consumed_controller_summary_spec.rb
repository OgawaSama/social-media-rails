require "rails_helper"

RSpec.describe ItemsConsumedController, type: :controller do
  describe "GET #summary" do
    before do
      @user1 = create(:user)
      @user2 = create(:user)

      create(:item_consumed, user: @user1, name: "Beer", brand: "Itaipava", item_type: "Beer", quantity: 2)
      create(:item_consumed, user: @user2, name: "Beer", brand: "Itaipava", item_type: "Beer", quantity: 3)
      create(:item_consumed, user: @user1, name: "Gin", brand: "GinCompany", item_type: "Beer", quantity: 1)
    end

    it "returns success" do
      sign_in FactoryBot.create(:user)
      get :summary
      expect(response).to have_http_status(:success)
    end

    it "assigns @summary grouped and summed" do
      sign_in FactoryBot.create(:user)
      get :summary

      summary = assigns(:summary)

      beer = summary.find { |s| s.name == "Beer" }
      gin   = summary.find { |s| s.name == "Gin" }

      expect(beer.total_quantity.to_i).to eq(5)
      expect(gin.total_quantity.to_i).to eq(1)
    end
  end
end
