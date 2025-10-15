class CardapiosController < ApplicationController
  before_action :set_business
  before_action :set_cardapio, only: [ :edit, :update ]

  def new
    @cardapio = @business.build_cardapio
    @cardapio.itens_cardapio.build
  end

  def create
    @cardapio = @business.build_cardapio(cardapio_params)
    if @cardapio.save
      redirect_to business_path(@business), notice: "Cardápio criado com sucesso!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @cardapio.update(cardapio_params)
      redirect_to business_path(@business), notice: "Cardápio atualizado com sucesso!"
    else
      render :edit
    end
  end

  private

  def set_business
    @business = Business.find(params[:business_id])
  end

  def set_cardapio
    @cardapio = @business.cardapio
  end

  def cardapio_params
    params.require(:cardapio).permit(:titulo, itens_cardapio_attributes: [ :id, :nome, :preco, :tipo, :_destroy ])
  end
end
