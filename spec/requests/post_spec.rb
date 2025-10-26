require 'rails_helper'

RSpec.describe Post, type: :request do
  before(:each) do
    @user = create(:user)
  end

  describe 'user is logged in' do
    before(:each) do
      login_as @user
      @post = create(:post, user: @user)
    end

    context 'GET posts/new' do
      it "should get new" do
        get new_post_url
        # expect(response).to redirect_to(new_post_path)
        expect(response).to have_http_status(:success)
      end
    end

    context 'GET posts/:post_id/edit' do
      it "should get edit" do
        get edit_post_url(@post)
        # expect(response).to redirect_to(edit_post_path)
        expect(response).to have_http_status(:success)
      end
    end

    context 'GET posts/:post_id' do
      it "should access existing post" do
        get post_url(@post)
        # expect(response).to redirect_to(post_path(@post))
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'user is not logged in' do
    before(:each) do
      @user2 = create(:user)
      @post2 = create(:post, user: @user2)
    end

    context "GET posts/new" do
      it "should not get new" do
        get new_post_url
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "GET posts/:post_id/edit" do
      it "should not get edit" do
        get edit_post_url(@post2)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "GET posts/:post_id" do
      it "should not access existing post" do
        get post_url(@post2)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end