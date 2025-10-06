class BusinessRegistrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_business, only: [ :edit, :update ]

  def new
    @business = Business.new
    @business.business_addresses.build
  end

  def create
    ActiveRecord::Base.transaction do
      current_user.update!(type: "BusinessUser")
      @business = Business.new(business_params.merge(user: current_user))
      @business.save!
    end
    redirect_to root_path, notice: "Perfil empresarial criado com sucesso!"
  rescue ActiveRecord::RecordInvalid
    flash.now[:alert] = "Erro ao criar perfil empresarial."
    render :new
  end

  def edit
    @business.business_addresses.build if @business.business_addresses.empty?
  end

  def update
    if @business.update(business_params)
      redirect_to root_path, notice: "Perfil empresarial atualizado com sucesso!"
    else
      flash.now[:alert] = "Erro ao atualizar perfil empresarial."
      render :edit
    end
  end

  private

  def set_business
    @business = current_user.business
    redirect_to root_path, alert: "Perfil empresarial não encontrado." unless @business
  end

  def business_params
    params.require(:business).permit(
      :company_name, :cnpj,
      business_addresses_attributes: [ :id, :street, :city, :state, :zip, :_destroy ]
    )
  end
end
