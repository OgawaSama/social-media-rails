require 'rails_helper'

RSpec.describe ItemConsumed, type: :request do
  before(:each) do
    @user = create(:user)
    @item = create(:item_consumed, user: @user)
  end

  describe 'user is logged in' do
    before(:each) do
      login_as @user
    end

    context 'GET item_consumed/:user_id/:item_consumed_id/new' do
      it "should get new" do
        get new_items_consumed_path(@post)
        expect(response).to have_http_status(:success)
      end
    end

    context 'GET item/:user_id/index' do
      it "should view my item list" do
        get items_consumed_index_path(user_id: @user.id)
        expect(response).to have_http_status(:success)
      end
    end

    context 'DELETE item/:user_id/:item_consumed_id' do
      it "should delete an item of mine" do
        delete "/items_consumed/#{@item.id}"
        expect(response).to have_http_status(:success)
      end

      it "should not delete someone else's item" do
        @other_user = create(:user)
        @other_item = create(:item_consumed, user: @other_user)
        delete "/items_consumed/#{@other_item.id}"
        expect(response).to_not have_http_status(:success)
      end
    end
  end

  describe 'user is not logged in' do
    context 'GET posts/:post_id/comments/new' do
      it "should not get new" do
        get new_items_consumed_path(@post)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'GET item/:user_id/index' do
      it "should not view an item list" do
        get items_consumed_index_path(user_id: @user.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'DELETE item/:user_id/:item_consumed_id' do
      it "should not delete an item" do
        delete "/items_consumed/#{@item.id}"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
