class BusinessCommentsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  before_action :set_business

  def index
    @business_comments = @business.business_comments.includes(:user).order(created_at: :desc)
  end

  def create
    @comment = @business.business_comments.new(comment_params.except(:role))
    @comment.user = current_user
    @comment.role = current_user.critic? ? "critic" : "consumer"
    if @comment.save
      @business_comments = @business.business_comments.includes(:user).order(created_at: :desc)
      respond_to do |format|
        format.turbo_stream { render :index }
        format.html { redirect_to business_path(@business), notice: "Comentário adicionado." }
        format.any  { render :index }
      end
    else
      @business_comments = @business.business_comments.includes(:user).order(created_at: :desc)
      respond_to do |format|
        format.turbo_stream { render :index, status: :unprocessable_entity }
        format.html { redirect_to business_path(@business), alert: "Não foi possível adicionar o comentário." }
        format.any  { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = @business.business_comments.find(params[:id])
    if @comment.user == current_user || current_user == @business.user
      @comment.destroy
      @business_comments = @business.business_comments.includes(:user).order(created_at: :desc)
      respond_to do |format|
        format.turbo_stream { render :index }
        format.html { redirect_to business_path(@business), notice: "Comentário removido." }
      end
    else
      redirect_to business_path(@business), alert: "Sem permissão para remover comentário."
    end
  end

  private

  def set_business
    @business = Business.find(params[:business_id])
  end

  def comment_params
    params.require(:business_comment).permit(:body)
  end
end
