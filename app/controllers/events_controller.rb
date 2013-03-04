#Events controller to be used by admin
#To create event items
class EventsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @events = Event.all
  end

  def edit
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to events_path
    else
      redirect_to events_path
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to events_path
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      redirect_to events_path
    end
  end
end
