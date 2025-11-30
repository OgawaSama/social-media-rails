class UsersController < ApplicationController
  before_action :authenticate_user!

  def celebrate_user
    @user = User.find(params[:user])
    @points = params[:points]
    # if anyone knows how to format rich_text manually, just fix this so that it looks better
    @post = current_user.posts.create!(
      caption: "Parabéns ao < @#{@user.username} > pelos seus impressionantes #{@points} pontos!!!",
      body: "Realmente impressionante. Esse usuário realmente é um dos ícones aqui da plataforma, tudo de bom pra ele. \n
      Não se esqueçam de checar o perfil dele, seguir e depois chamar pra sair, porque é garantido que ele vai querer! \n
      Como bebe! Como come! Como consome!! \n
      É isso galera, confere lá o perfil, dá um follow, ativa sininho, faz tudo aí que tá valendo a pena!!!! \n

      Esta mensagem foi escrita automaticamente ao parabenizar < @#{@user.username} > via o Ranking de Consumo."
    )
    respond_to do |format|
      format.html { redirect_to @post, notice: "Usuário celebrado!" }
      format.json { render :show, status: :created, location: @post }
    end
  end

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
