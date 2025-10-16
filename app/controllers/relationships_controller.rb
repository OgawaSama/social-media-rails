class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :create, :destroy ]

  def create
    current_user.follow(@user)

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: "Agora você está seguindo #{@user.username}" }
      format.turbo_stream
    end
  end

  def destroy
    current_user.unfollow(@user)

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: "Você deixou de seguir #{@user.username}" }
      format.turbo_stream
    end
  end

  private

  def set_user
    # Busca o usuário via params[:id] enviado pelo botão
    @user = User.find_by(id: params[:id])
    unless @user
      redirect_back fallback_location: root_path, alert: "Usuário não encontrado."
    end
  end
end
