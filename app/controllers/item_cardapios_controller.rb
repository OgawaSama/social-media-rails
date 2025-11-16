class ItemCardapiosController < ApplicationController
  before_action :authenticate_user!

  def add_rating
    item = ItemCardapio.find(params[:id])
    rating = params[:rating].to_i

    # Check if user already rated this item
    item_rate = item.item_rates.find_or_initialize_by(user: current_user)
    item_rate.rating = rating

    if item_rate.save
      # Recalculate average rating for the item
      update_item_rating(item)
      redirect_back fallback_location: root_path, notice: "Avaliação adicionada com sucesso."
    else
      redirect_back fallback_location: root_path, alert: "Erro ao adicionar avaliação."
    end
  end

  private

  def update_item_rating(item)
    average_rating = item.item_rates.average(:rating).to_f
    item.update(rating: average_rating)
  end
end
