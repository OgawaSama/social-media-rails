class EventsController < ApplicationController
  before_action :authenticate_user! # Garante que o usuário esteja logado
  before_action :set_event, only: [:show]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.creator = current_user 

    if @event.save
      create_time_slots_for_event(@event)
      redirect_to @event, notice: 'Evento criado com sucesso!'
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def show
    @time_slots_by_day = @event.time_slots
                               .order(:start_time)
                               .group_by { |slot| slot.start_time.to_date }

    @availabilities = @event.availabilities.includes(:user).index_by { |a| [a.user_id, a.time_slot_id] }
    @participants = User.where(id: @availabilities.keys.map(&:first).uniq)

  end

  private

  def set_event
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Evento não encontrado." 
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :end_date)
  end

  def create_time_slots_for_event(event)
    time_slots_attributes = []
    current_day = event.start_date
    while current_day <= event.end_date
      (9..17).each do |hour| 
        start_time = DateTime.new(current_day.year, current_day.month, current_day.day, hour, 0, 0, Time.zone.formatted_offset)
        end_time = start_time + 1.hour
        time_slots_attributes << { event_id: event.id, start_time: start_time, end_time: end_time, created_at: Time.current, updated_at: Time.current }
      end
      current_day += 1.day
    end

    TimeSlot.insert_all(time_slots_attributes) if time_slots_attributes.any?
  end

end