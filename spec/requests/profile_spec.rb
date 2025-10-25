require 'rails_helper'

RSpec.describe Profile, type: :request do
  before(:each) do
    @user = create(:user)
    @user2 = create(:user)
    @profile2 = @user2.profile
  end
  
  describe 'user is logged in' do
    before(:each) do
      login_as @user
      @profile = @user.profile
    end

    context 'GET profiles/:profile_id/edit' do
      it "should get edit" do
        get edit_profile_url(@profile)
        # expect(response).to redirect_to(edit_profile_path(@profile))
        expect(response).to have_http_status(200)
      end
    end

    context 'GET profiles/:profile_id' do
      it "should access my profile" do
        get profile_url(@profile)
        # expect(response).to redirect_to(profile_path(@profile))
        expect(response).to have_http_status(200)
      end
    end

    context 'GET profiles/:profile_id' do
      it "should access someone else's profile" do
        get profile_url(@profile2)
        # expect(response).to redirect_to(profile_path(@profile2))
        expect(response).to have_http_status(200)
      end
    end

    it "needs some fixing" do
      pending "fix the redirects from OK. maybe reduce overhead"
    end

  end

  describe 'user is not logged in' do
    context 'GET profiles/:profile_id/edit' do
      it "should not get edit" do
        get edit_profile_url(@profile2)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'GET profiles/:profile_id' do
      it "should not access someone else's profile" do
        get profile_url(@profile2)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end