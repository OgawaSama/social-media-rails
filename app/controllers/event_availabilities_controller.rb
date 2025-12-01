class EventAvailabilitiesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_event

    def show
        @time_slots_by_day = @event.time_slots.order(:start_time).group_by { |slot| slot.start_time.to_date }
        @my_availabilities = current_user.availabilities.where(time_slot_id: @event.time_slot_ids).index_by(&:time_slot_id)
    end

    def update
        data = params[:availabilities] || {}
        records = []

        data.each do |slot_id, status|
            next unless Availability.statuses.keys.include?(status)
            records << {
                user_id: current_user.id,
                time_slot_id: slot_id.to_i,
                status: Availability.statuses[status],
                created_at: Time.current,
                updated_at: Time.current
            }
        end

        if records.any?
            Availability.upsert_all(records, unique_by: [ :user_id, :time_slot_id ])
            redirect_to event_path(@event), notice: "Disponibilidade salva!"
        else
            redirect_to event_my_availability_path(@event), alert: "Nada alterado."
        end
    end

    alias_method :create, :update

    private
    def set_event
        @event = Event.find(params[:event_id])
    end
end
