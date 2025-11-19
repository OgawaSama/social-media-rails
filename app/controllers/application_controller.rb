class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  def following_businesses
    @user = User.find(params[:id])
    @following_businesses = @user.following_businesses.includes(:business_addresses, user: :profile)
  end
end
