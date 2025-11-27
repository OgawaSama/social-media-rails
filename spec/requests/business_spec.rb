require 'rails_helper'

RSpec.describe 'Businesses', type: :request do
  before(:each) do
    @user = create(:business_user)
    @business = @user.business
  end

  describe 'user is logged in' do
    before(:each) do
      sign_in @user
    end

    context 'GET business_registration/new' do
      it "should get new" do
        get new_business_url
        expect(response).to have_http_status(:success)
      end
    end

    context 'GET business_registration/:user_id/edit' do
      it "should get edit" do
        get edit_business_url(@business)
        expect(response).to have_http_status(:success)
      end
    end

    context 'GET business/:business_id' do
      it "should access existing business" do
        get business_url(@business)
        expect(response).to have_http_status(200)
      end
    end

    # NOVOS TESTES PARA AS NOVAS FUNCIONALIDADES
    context 'GET /businesses' do
      it "should access businesses index" do
        get businesses_url
        expect(response).to have_http_status(200)
      end
    end

    context 'POST /businesses/:id/follow' do
      it "should follow a business" do
        other_business = create(:business, business_type: 'restaurant')
        expect {
          post follow_business_url(other_business)
        }.to change { @user.following_businesses.count }.by(1)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'DELETE /businesses/:id/unfollow' do
      it "should unfollow a business" do
        other_business = create(:business, business_type: 'restaurant')
        @user.follow_business(other_business)
        expect {
          delete unfollow_business_url(other_business)
        }.to change { @user.following_businesses.count }.by(-1)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'GET /users/:id/following_businesses' do
      it "should access following businesses page" do
        get following_businesses_user_url(@user)
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
      end
    end

    context "GET business/:business_id" do
      it "should not access existing business" do
        get business_url(@business)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    # NOVOS TESTES PARA AS NOVAS FUNCIONALIDADES
    context 'GET /businesses' do
      it "should not access businesses index" do
        get businesses_url
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'POST /businesses/:id/follow' do
      it "should not follow a business" do
        post follow_business_url(@business2)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'GET /users/:id/following_businesses' do
      it "should not access following businesses page" do
        get following_businesses_user_url(@user2)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
