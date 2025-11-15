class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_business_address
  before_action :require_business_owner, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]

  def index
    @events = @business_address.events.order(start_time: :asc)
  end

  def show
  end

  def new
    @event = @business_address.events.new
  end

  def create
    @event = @business_address.events.new(event_params)
    if @event.save
      redirect_to business_business_address_events_path(@business_address.business, @business_address), notice: "Evento criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to business_business_address_events_path(@business_address.business, @business_address), notice: "Evento atualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to business_business_address_events_path(@business_address.business, @business_address), notice: "Evento removido."
  end

  private

  def set_business_address
    @business_address = BusinessAddress.find(params[:business_address_id])
  end

  def set_event
    @event = @business_address.events.find(params[:id])
  end

  def require_business_owner
    unless current_user == @business_address.business.user
      redirect_to root_path, alert: "Apenas o dono do negócio pode gerenciar eventos." and return
    end
  end

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :end_time, :points_rewarded)
  end
end
