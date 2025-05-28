class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    redirect_to events_path unless current_user.admin?
    @event = Event.new
  end

  def create
    redirect_to events_path unless current_user.admin?
    @event = Event.new(params[:event])
    if @event.save
      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    redirect_to events_path unless current_user.admin?
    @edit = Edit.find(params[:id])
  end

  def update
    redirect_to events_path unless current_user.admin?
    @event = Event.find(params[:id])
    @event.update(params[:event])
    redirect_to event_path(@event)
  end

  def destroy
    redirect_to events_path unless current_user.admin?
    @event = Event.find(params[:id])
    @event.destroy
  end

  private

  def event_params
    params.require(:event).permit(:event_name, :description, :location, :time, :date)
  end
end
