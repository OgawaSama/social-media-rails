class FeedController < ApplicationController
  before_action :authenticate_user!

  def show
    # Pega os posts do usuário atual + posts de quem ele segue
    @posts = current_user.feed.includes(:user, :reactions, :comments)
  end

  def search
    @users = User.where("username LIKE ? OR email LIKE ?",
                       "%#{params[:query]}%",
                       "%#{params[:query]}%")
  end

  def search_shops
    @query = params[:query]
    @shops = Business.where(id: BusinessAddress.where(
                              id: Cardapio.where(
                                id: ItemCardapio.where("nome LIKE ?", "%#{@query}%").pluck(:cardapio_id)
                              ).pluck(:business_address_id)
                            ).pluck(:business_id)).all.reorder("rating DESC")
  end
end
