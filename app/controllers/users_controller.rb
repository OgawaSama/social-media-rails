class UsersController < ApplicationController
  before_action :authenticate_user!

  def groups
    @user = User.find(params[:id])
    @groups = @user.groups.includes(:profile)
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.includes(:profile)
  end

  def following
    @user = User.find(params[:id])
    @following = @user.following.includes(:profile)
  end
   def following_businesses
    @user = User.find(params[:id])
    @following_businesses = @user.following_businesses.includes(:business_addresses, user: :profile)
  end
end
