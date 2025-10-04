class FeedController < ApplicationController
  def show
    @posts = Post.all
  end

  # [bookmark] editar a query para aceitar outras coisas
  def search
    if params[:query].present?
      query = "%#{params[:query]}%"
      @users = User.joins(:profile).where(
        "users.username LIKE :q",
        q: query
      )
    else
      @users = User.none
    end
  end
end
