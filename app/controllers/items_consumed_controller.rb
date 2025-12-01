class ItemsConsumedController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: %i[ show edit update destroy check_user ]
  before_action :set_user, only: %i[ index ]
  before_action :check_user, only: %i[ destroy ]

  def summary
    @summary = ItemConsumed
                .select("name, brand, item_type, SUM(quantity) AS total_quantity")
                .group(:name, :brand, :item_type)
                .order("total_quantity DESC")
  end

  def ranking
    @rankings = User
                .joins(:items_consumed)
                .select("user_id, username, SUM(worth * quantity) AS points")
                .group(:username)
                .order("points DESC")
  end

  def friends_ranking
    connections = User.where(id: current_user.following_ids).or(User.where(id: current_user.follower_ids))
    @friends = User
                  .joins(:items_consumed)
                  .select("user_id, username, SUM(worth*quantity) AS points, date")
                  .group(:username)
                  .order("points DESC")
    @start = params[:start_date]
    @end = params[:end_date]
    if @start != "" && @end != ""
      @friends = @friends.where("date BETWEEN ? AND ?", @start, @end)
    end
  end

  def show
  end

  def new
    @item = current_user.items_consumed.build
    @items = ItemCardapio.order(cardapio_id: :desc)
  end

  def index
    @items = ItemConsumed.where(user: @user).order(date: :desc)
  end

  def update
    if @item.update(items_consumed_params)
      redirect_to profile_path(@user.profile), notice: "Report was successfully updated!"
    else
      render :edit
    end
  end

  def edit
  end

  def create
    @item = current_user.items_consumed.new(items_consumed_params)
    @user = current_user
    @brand = items_consumed_params[:brand]
    @name = items_consumed_params[:name]
    @type = items_consumed_params[:item_type]

    # worth = existing_item.worth. if doesnt exist, = 0
    @business = Business.find_by(id: BusinessAddress.where(id: Cardapio.where(id: ItemCardapio.where(nome: @name).pluck(:cardapio_id)).pluck(:business_address_id)).pluck(:business_id))
    if @business&.company_name == @brand
      @worth = ItemCardapio.find_by(cardapio: Cardapio.find_by(business_address_id: @business.business_addresses)).worth
    else
      @worth = 0
    end
    if ItemConsumed.where(user: @user, brand: @brand, item_type: @type, name: @name).exists?
      @old_item = ItemConsumed.find_by(user: @user, brand: @brand, item_type: @type, name: @name)
      new_quantity = @old_item.quantity + @item.quantity
      @old_item.update(quantity: new_quantity, worth: @worth)
      if @old_item.save
        redirect_to items_consumed_index_path(user_id: @user.id), notice: "item updated!"
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    else
      if @item.save
        redirect_to items_consumed_index_path(user_id: @user.id), notice: "new item created!"
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(items_consumed_params)
        format.html { redirect_to @item, notice: "Item was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item = ItemConsumed.find(params[:id])
    if @item.user == current_user
      @item.destroy
    else
      redirect_to root_path, alert: "Sem permissão para remover comentário."
    end
  end

  def check_user
    return if @item.user == current_user

    redirect_to root_path, notice: "You're not the owner."
  end

  private

  def set_item
    @item = ItemConsumed.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def items_consumed_params
    params.require(:item_consumed).permit(:item_consumed_id, :name, :quantity, :brand, :item_type, :date, :worth)
  end
end
