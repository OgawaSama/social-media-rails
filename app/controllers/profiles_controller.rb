class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: %i[show edit update destroy]

  # GET /profiles
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  def show
    @posts = @profile.user.posts.order(created_at: :desc)
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # POST /profiles
  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to @profile, notice: "Profile was successfully created!"
    else
      render :new
    end
  end

  # GET /profiles/1/edit
  def edit
  end

  # PATCH/PUT /profiles/1
  # app/controllers/profiles_controller.rb
  def update
    begin
      # Checa avatar
      if profile_params[:avatar].present?
        avatar_blob = ActiveStorage::Blob.find_signed(profile_params[:avatar])
        unless avatar_blob.service.exist?(avatar_blob.key)
          redirect_to edit_profile_path(@profile), alert: "O arquivo de avatar está no formato incorreto. Por favor suba um novo." and return
        end
      end

      # Checa header
      if profile_params[:header].present?
        header_blob = ActiveStorage::Blob.find_signed(profile_params[:header])
        unless header_blob.service.exist?(header_blob.key)
          redirect_to edit_profile_path(@profile), alert: "O arquivo de header está no formato incorreto. Por favor suba um novo." and return
        end
      end

      # Atualiza o profile
      if @profile.update(profile_params)
        redirect_to @profile, notice: "Profile was successfully updated!"
      else
        render :edit
      end

    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to edit_profile_path(@profile), alert: "O arquivo enviado é inválido."
    end
  end


  # DELETE /profiles/1
  def destroy
    @profile.destroy
    redirect_to profiles_url, notice: "Profile was successfully destroyed!"
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:bio, :header, :avatar).delete_if { |k,v| v.blank? }
  end
end