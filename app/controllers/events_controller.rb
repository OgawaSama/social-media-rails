class EventsController < ApplicationController
  before_action :authenticate_user!
  
  before_action :set_business_address, if: -> { params[:business_address_id].present? }
  
  # Só exige ser dono se achou um endereço de negócio
  before_action :require_business_owner, only: [:new, :create, :edit, :update, :destroy], if: -> { @business_address.present? }
  
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    if @business_address
      @events = @business_address.events.order(start_time: :asc)
    else
      # Lista apenas os eventos criados pelo usuário (Rolês)
      @events = current_user.created_events
    end
  end

  def show
    # Se tiver slots (é um Rolê), carrega dados do When2Meet
    if @event.respond_to?(:time_slots) && @event.time_slots.any?
      @time_slots_by_day = @event.time_slots.order(:start_time).group_by { |slot| slot.start_time.to_date }
      @availabilities = @event.availabilities.index_by { |a| [a.user_id, a.time_slot_id] }
      
      # Pega participantes únicos
      ids = @availabilities.keys.map(&:first).uniq
      ids << @event.creator_id if @event.creator_id
      @participants = User.where(id: ids.uniq)
    end
  end

  def new
    @event = Event.new
    # Se estamos no contexto de negócio, já preenchemos
    @event.business_address = @business_address if @business_address
  end

  def create
    @event = Event.new(event_params)

    if @business_address
      # --- CRIAR EVENTO DE NEGÓCIO ---
      @event.business_address = @business_address
      if @event.save
        redirect_to business_business_address_events_path(@business_address.business, @business_address), notice: "Evento criado."
      else
        render :new, status: :unprocessable_entity
      end
    else
      # --- CRIAR ROLÊ (SOCIAL) ---
      @event.creator = current_user
      if @event.save
        create_time_slots_for_event(@event)
        redirect_to @event, notice: 'Rolê criado com sucesso!'
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Evento atualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to feed_path, notice: "Evento removido."
  end

  private

  def set_business_address
    @business_address = BusinessAddress.find(params[:business_address_id])
  end

  def set_event
    if @business_address
      @event = @business_address.events.find(params[:id])
    else
      @event = Event.find(params[:id])
    end
  end

  def require_business_owner
    unless current_user == @business_address.business.user
      redirect_to root_path, alert: "Acesso negado."
    end
  end

  def event_params
    # Aceita tanto params de negócio quanto de rolê
    params.require(:event).permit(:name, :description, :start_time, :end_time, :points_rewarded, :title, :start_date, :end_date)
  end

  def create_time_slots_for_event(event)
    # Garante que tem datas
    inicio = event.start_time || event.start_date
    fim = event.end_time || event.end_date
    return unless inicio && fim

    time_slots = []
    (inicio.to_date..fim.to_date).each do |date|
      (9..17).each do |hour|
        start_t = date.to_time.change(hour: hour, min: 0, sec: 0)
        end_t = start_t + 1.hour
        time_slots << { event_id: event.id, start_time: start_t, end_time: end_t, created_at: Time.current, updated_at: Time.current }
      end
    end
    TimeSlot.insert_all(time_slots) if time_slots.any?
  end
end