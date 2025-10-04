class PagesController < ApplicationController
  def userindex
    @users = User.all
  end

  def barindex
  end
end
