require 'rails_helper'

RSpec.describe Reaction, type: :request do
  before(:each) do
    @user = create(:user)
    @post = create(:post, user: @user)
  end

  describe 'user is logged in' do
    before(:each) do
      login_as @user
    end

    context 'POST posts/:post_id/reactions' do
      it "should post reaction" do
        post post_reactions_url(@post, "heart")
        # expect(response).to redirect_to(new_post_comment_path(@post))
        expect(response).to have_http_status(:success)
      end
    end
  end
end
