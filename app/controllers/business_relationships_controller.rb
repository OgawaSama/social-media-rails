class BusinessRelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_business, only: [ :create, :destroy ]

  def create
    current_user.follow_business(@business)

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: "Agora você está seguindo #{@business.company_name}" }
      format.turbo_stream
    end
  end

  def destroy
    current_user.unfollow_business(@business)

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: "Você deixou de seguir #{@business.company_name}" }
      format.turbo_stream
    end
  end

  private

  def set_business
    @business = Business.find_by(id: params[:id])
    unless @business
      redirect_back fallback_location: root_path, alert: "Bar/empresa não encontrado."
    end
  end
end
