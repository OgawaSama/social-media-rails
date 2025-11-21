require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:business) { create(:business) }

  before { sign_in user }

  describe 'GET #following_businesses' do
    before { user.follow_business(business) }

    it 'returns http success' do
      get :following_businesses, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end

    it 'assigns @following_businesses with followed businesses' do
      get :following_businesses, params: { id: user.id }
      expect(assigns(:following_businesses)).to include(business)
    end

    it 'assigns @user' do
      get :following_businesses, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end
  end
end
