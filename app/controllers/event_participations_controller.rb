class EventParticipationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    participation = @event.event_participations.new(user: current_user)
    if participation.save
      redirect_to business_business_address_event_path(@event.business_address.business, @event.business_address, @event), notice: "Participação registrada! Você ganhou #{participation.event.points_rewarded || 0} pontos."
    else
      redirect_to business_business_address_event_path(@event.business_address.business, @event.business_address, @event), alert: "Você já está participando deste evento."
    end
  end

  private
  def set_event
    @event = Event.find(params[:event_id])
  end
end
