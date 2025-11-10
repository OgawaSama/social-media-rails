require 'rails_helper'

RSpec.describe Business, type: :request do
  before(:each) do
    @user = create(:business_user)
    @business = @user.business
  end

  describe 'user is logged in' do
    before(:each) do
      login_as @user
    end

    context 'GET business_registration/new' do
      it "should get new" do
        get new_business_url
        # expect(response).to redirect_to(new_business_registration_path)
        expect(response).to have_http_status(:success)
      end
    end

    context 'GET business_registration/:user_id/edit' do
      it "should get edit" do
        get edit_business_url(@business)
        # expect(response).to redirect_to(new_business_path(@user))
        expect(response).to have_http_status(:success)
      end
    end

    context 'GET business/:business_id' do
      it "should access existing business" do
        get business_url(@business)
        # expect(response).to redirect_to(post_path(@post))
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'user is not logged in' do
    before(:each) do
      @user2 = create(:business_user)
      @business2 = @user2.business
    end

    context 'GET business_registration/new' do
      it "should not get new" do
        get new_business_url
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'GET business_registration/:user_id/edit' do
      it "should not get edit" do
        get edit_business_url(id: @business2.id)
        expect(response).to redirect_to(new_user_session_path)
        # expect(response).to have_http_status(:unauthorized)
      end
    end

    context "GET business/:business_id" do
      it "should not access existing business" do
        get business_url(@business)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
