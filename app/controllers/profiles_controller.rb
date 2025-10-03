class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: %i[ show edit update ]

  # GET /profiles/1/edit
  def edit
  end

  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: "Profile was successfully updated!"
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      params.expect(profile: [ :bio, :header, :avatar, :user_id ])
    end
end
