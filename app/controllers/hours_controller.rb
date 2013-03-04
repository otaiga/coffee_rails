#Hours controller to be used by admin
#To create Opening Times
class HoursController < ApplicationController
  before_filter :authenticate_user!

  def index
    @opening_times = OpeningTime.all
  end

  def edit
    @opening_time = OpeningTime.find(params[:id])
  end

  def new
    @opening_time = OpeningTime.new
  end

  def create
    @opening_time = OpeningTime.new(params[:opening_time])
    if @opening_time.save
      redirect_to hours_path
    else
      redirect_to hours_path
    end
  end

  def update
    @opening_time = OpeningTime.find(params[:id])
    if @opening_time.update_attributes(params[:opening_time])
      redirect_to hours_path
    end
  end

  def destroy
    @opening_time = OpeningTime.find(params[:id])
    if @opening_time.destroy
      redirect_to hours_path
    end
  end

end