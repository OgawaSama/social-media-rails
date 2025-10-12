class FeedController < ApplicationController
  before_action :authenticate_user!

  def show
    # Pega os posts do usuário atual + posts de quem ele segue
    @posts = current_user.feed.includes(:user, :reactions, :comments)
  end

  def search
    @users = User.where("username LIKE ? OR email LIKE ?",
                       "%#{params[:query]}%",
                       "%#{params[:query]}%")
  end
end
