require 'rails_helper'
require 'pp'

RSpec.describe Group, type: :request do
  before(:each) do
    @user = create(:user)
  end

  describe 'user is logged in' do
  before(:each) do
    # evita que o job de resize quebre os requests
    allow(ResizeImageJob).to receive(:perform_later)

    login_as @user
    @group = create(:group)
    GroupParticipation.create!(group: @group, user: @user)
  end


    context 'GET users/:user_id/:group_id' do
      it "should get a group I own" do
        get group_url(@group)
        # expect(response).to redirect_to(group_path(@group))
        expect(response).to have_http_status(:success)
      end
    end

    context 'GET groups/new' do
      it "should get new" do
        get new_group_url
        # expect(response).to redirect_to(new_group_path)
        expect(response).to have_http_status(:success)
      end
    end

    context 'GET groups/:group_id/edit' do
      it "should get edit" do
        get edit_group_url(@group)
        # expect(response).to redirect_to(edit_group_path)
        expect(response).to have_http_status(:success)
      end
    end

    context 'GET users/:user_id/groups' do
      before(:each) do
        @user2 = create(:user)
        @group2 = create(:group)
      end

      it "should not access a group you're not member of" do
        get group_url(@group2)
        expect(response).to redirect_to(root_path)
        # expect(response).to have_http_status(200)
      end
    end
  end

  describe 'user is not logged in' do
  before(:each) do
    allow(ResizeImageJob).to receive(:perform_later)

    @group = create(:group)
  end


    context 'GET users/:user_id/:group_id' do
      it "should not get group" do
        get group_url(@group)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'GET groups/new' do
      it "should not get new" do
        get new_group_url
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'GET groups/:group_id/edit' do
      it "should not get edit" do
        get edit_group_url(@group)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
