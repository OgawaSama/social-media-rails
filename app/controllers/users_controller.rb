class UsersController < ApplicationController
  before_action :authenticate_user!

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.includes(:profile)
  end

  def following
    @user = User.find(params[:id])
    @following = @user.following.includes(:profile)
  end
end
