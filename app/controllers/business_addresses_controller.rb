class BusinessAddressesController < ApplicationController
  before_action :set_business
  before_action :set_address, only: [ :show, :edit, :update, :destroy ]

  def show
    @cardapio = @address.cardapio
    @itens = @cardapio&.itens_cardapio
  end

  def new
    @address = @business.business_addresses.build
  end

  def create
    @address = @business.business_addresses.build(address_params)
    if @address.save
      redirect_to business_business_address_path(@business, @address), notice: "Endereço criado!"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @address.update(address_params)
      redirect_to business_business_address_path(@business, @address), notice: "Endereço atualizado!"
    else
      render :edit
    end
  end

  private

  def set_business
    @business = Business.find(params[:business_id])
  end

  def set_address
    @address = @business.business_addresses.find(params[:id])
  end

  def address_params
    params.require(:business_address).permit(:street, :city, :state, :zip)
  end
end
