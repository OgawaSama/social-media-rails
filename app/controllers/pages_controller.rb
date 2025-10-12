class PagesController < ApplicationController
  # NOT USED; REFER TO OTHER CONTROLLERS
  def userindex
    @users = User.all
  end

  def barindex
  end
end
