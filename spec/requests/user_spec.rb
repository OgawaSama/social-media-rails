require 'rails_helper'

RSpec.describe "Users", type: :request do
  before(:each) do
    @user = create(:user)
    # login_as @user
  end

  
  describe 'GET /users/edit' do
    context 'user is logged in' do
      it "gets edit page" do
        login_as @user
        get edit_user_registration_url
        expect(response).to render_template(:edit)
      end
    end

    context 'user is not logged in' do
      it "redirects to new user creation" do
        get edit_user_registration_url
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /users/sign_up' do
    context 'user is logged in' do
      it "redirects to root" do
        login_as @user
        get new_user_registration_url
        expect(response).to redirect_to(root_path)
        # expect(flash[:already_authenticated]).to eq("aa")
      end
    end

    context 'user is not logged in' do
      it "redirects to root" do
        get new_user_registration_url
        expect(response).to have_http_status(200)
        # expect(response).to redirect_to(new_user_registration_path)
      end
    end
  end

    describe 'GET /users/sign_in' do
    context 'user is logged in' do
      it "redirects to root" do
        login_as @user
        get new_user_session_url
        expect(response).to redirect_to(root_path)
        # expect(flash[:already_authenticated]).to eq("aa")
      end
    end

    context 'user is not logged in' do
      it "redirects to root" do
        get new_user_session_url
        # expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(200)

      end
    end
  end

  it "needs some fixing" do
    pending "fix the flash and redirects from OK"
  end

end
