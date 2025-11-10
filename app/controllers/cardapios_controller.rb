class CardapiosController < ApplicationController
  before_action :set_business
  before_action :set_business_address
  before_action :set_cardapio, only: [ :show, :edit, :update ]

  def show
    @itens = @cardapio.itens_cardapio
  end

  def new
    @cardapio = @business_address.build_cardapio
    @cardapio.itens_cardapio.build
  end

  def create
    @cardapio = @business_address.build_cardapio(cardapio_params)
    if @cardapio.save
      redirect_to business_business_address_cardapio_path(@business, @business_address), notice: "Cardápio criado com sucesso!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @cardapio.update(cardapio_params)
      redirect_to business_business_address_cardapio_path(@business, @business_address), notice: "Cardápio atualizado com sucesso!"
    else
      render :edit
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

  def cardapio_params
    params.require(:cardapio).permit(
      :titulo,
      itens_cardapio_attributes: [ :id, :nome, :preco, :tipo, :_destroy ]
    )
  end
end
