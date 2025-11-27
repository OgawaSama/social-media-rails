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
    # Garante que o business seja carregado se existir
    @business = @profile.user.business if @profile.user.type == "BusinessUser"
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
  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: "Profile was successfully updated!"
    else
      flash.now[:alert] = @profile.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to edit_profile_path(@profile), alert: "O arquivo enviado é inválido."
  rescue => e
    Rails.logger.error("Erro ao atualizar perfil: #{e.message}")
    redirect_to edit_profile_path(@profile), alert: "Ocorreu um erro ao atualizar o perfil. Tente novamente."
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
    params.require(:profile).permit(:bio, :header, :avatar).delete_if { |k, v| v.blank? }
  end
end
