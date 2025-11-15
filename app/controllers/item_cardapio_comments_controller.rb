class ItemCardapioCommentsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  before_action :set_business
  before_action :set_business_address
  before_action :set_cardapio

  def index
    @comments = ItemCardapioComment.where(item_cardapio_id: params[:item_cardapio_id]).includes(:user).order(created_at: :desc)
  end

  def create
    item = ItemCardapio.find(params.dig(:item_cardapio_comment, :item_cardapio_id) || params[:item_cardapio_id])
    permitted = item_cardapio_comment_params.except(:role)
    @comment = item.item_cardapio_comments.new(permitted)
    @comment.user = current_user
    @comment.role = current_user.critic? ? "critic" : "consumer"
    if @comment.save
      @comments = item.item_cardapio_comments.includes(:user).order(created_at: :desc)
      respond_to do |format|
        format.turbo_stream { render :index }
        format.html { redirect_to business_business_address_cardapio_path(@business, @business_address), notice: "Comentário adicionado." }
        format.any  { render :index }
      end
    else
      @comments = item.item_cardapio_comments.includes(:user).order(created_at: :desc)
      respond_to do |format|
        format.turbo_stream { render :index, status: :unprocessable_entity }
        format.html { redirect_to business_business_address_cardapio_path(@business, @business_address), alert: "Não foi possível adicionar o comentário." }
        format.any  { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = ItemCardapioComment.find(params[:id])
    if @comment.user == current_user || current_user == @cardapio.business_address.business.user
      item = @comment.item_cardapio
      @comment.destroy
      @comments = item.item_cardapio_comments.includes(:user).order(created_at: :desc)
      respond_to do |format|
        format.turbo_stream { render :index }
        format.html { redirect_to business_business_address_cardapio_path(@business, @business_address), notice: "Comentário removido." }
      end
    else
      redirect_to business_business_address_cardapio_path(@business, @business_address), alert: "Sem permissão para remover comentário."
    end
  end

  private

  def set_business
    @business = Business.find(params[:business_id])
  end

  def set_business_address
    @business_address = @business.business_addresses.find(params[:business_address_id])
  end

  def set_cardapio
    @cardapio = @business_address.cardapio
  end

  def item_cardapio_comment_params
    params.require(:item_cardapio_comment).permit(:body, :item_cardapio_id)
  end
end
