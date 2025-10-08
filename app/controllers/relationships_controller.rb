class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    # Debug: veja quais parâmetros estão chegando
    puts "Params recebidos: #{params.inspect}"
    
    # Tente encontrar o usuário de várias formas
    @user = User.find_by(id: params[:user_id]) || 
            User.find_by(id: params[:id]) ||
            (params[:relationship] && User.find_by(id: params[:relationship][:followed_id]))
    
    if @user.nil?
      redirect_back fallback_location: root_path, alert: "Usuário não encontrado."
      return
    end

    if current_user.follow(@user)
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path, notice: "Agora você está seguindo #{@user.username}" }
        format.turbo_stream
      end
    else
      redirect_back fallback_location: root_path, alert: "Não foi possível seguir o usuário."
    end
  end

  def destroy
    # Debug: veja quais parâmetros estão chegando
    puts "Params recebidos (destroy): #{params.inspect}"
    
    # Tente encontrar o usuário de várias formas
    @user = User.find_by(id: params[:user_id]) || 
            User.find_by(id: params[:id]) ||
            Relationship.find_by(id: params[:id])&.followed

    if @user.nil?
      redirect_back fallback_location: root_path, alert: "Usuário não encontrado."
      return
    end

    if current_user.unfollow(@user)
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path, notice: "Você deixou de seguir #{@user.username}" }
        format.turbo_stream
      end
    else
      redirect_back fallback_location: root_path, alert: "Não foi possível deixar de seguir o usuário."
    end
  end
end
