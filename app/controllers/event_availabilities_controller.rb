class EventAvailabilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  # GET /events/:event_id/my_availability
  def show
    # Carrega os slots de tempo, agrupados por dia, ordenados
    @time_slots_by_day = @event.time_slots
                               .order(:start_time)
                               .group_by { |slot| slot.start_time.to_date }

    
    @my_availabilities = current_user.availabilities
                                     .where(time_slot_id: @event.time_slot_ids)
                                     .index_by(&:time_slot_id) 
  end

  def update
    availability_data = params.require(:availabilities).permit!.to_h 

    records_to_upsert = []
    valid_time_slot_ids = @event.time_slot_ids 

    availability_data.each do |time_slot_id_str, status_str|
      time_slot_id = time_slot_id_str.to_i
      next unless valid_time_slot_ids.include?(time_slot_id) && status_str.present? && Availability::STATUS.key?(status_str.to_sym)

      records_to_upsert << {
        user_id: current_user.id,
        time_slot_id: time_slot_id,
        status: Availability::STATUS[status_str.to_sym],
        created_at: Time.current,
        updated_at: Time.current
      }
    end

    if records_to_upsert.any?
      Availability.upsert_all(records_to_upsert, unique_by: [:user_id, :time_slot_id])
      redirect_to event_path(@event), notice: 'Disponibilidade atualizada com sucesso!'
    else
      redirect_to event_my_availability_path(@event), alert: 'Nenhuma disponibilidade válida para atualizar.'
    end

  rescue ActionController::ParameterMissing => e
    redirect_to event_my_availability_path(@event), alert: "Erro ao processar disponibilidades: #{e.message}"
  end

  alias_method :create, :update

  private

  def set_event
    @event = Event.find(params[:event_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Evento não encontrado."
  end

end