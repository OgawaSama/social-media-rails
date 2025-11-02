class BusinessesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_business, only: [ :edit, :update, :show, :add_rating ]
  before_action :set_user, only: [ :add_rating ]
  after_action :calculate_rating, only: [ :add_rating ]

  def show
    @addresses = @business.business_addresses.includes(:cardapio)
  end

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

  def add_rating
    if !Rate.where(business: @business, user: @user).present?
      Rate.create!(business: @business, user: @user, rating: params[:rating])
    else
      Rate.update!(business: @business, user: @user, rating: params[:rating])
    end
  end

  private

  def set_business
    @business = Business.find(params[:id])
    redirect_to root_path, alert: "Perfil empresarial não encontrado." unless @business
  end

  def business_params
    params.require(:business).permit(
      :company_name, :cnpj,
      business_addresses_attributes: [ :id, :street, :city, :state, :zip, :_destroy ]
    )
  end

  def calculate_rating
    old_rating = @business.rating
    new_rating = Rate.where(business: @business).average(:rating)
    if new_rating != nil
      @business.rating = new_rating
      @business.save!
    end
  end

  def set_user
    @user = current_user
  end
end
