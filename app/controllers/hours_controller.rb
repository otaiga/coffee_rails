#Hours controller to be used by admin
#To create Opening Times
class HoursController < ApplicationController
  before_filter :authenticate_user!

  def index
    @opening_times = OpeningTime.all
  end

  def edit
    @opening_time = OpeningTime.find(params[:id])
    editable = sort_days << @opening_time.weekday
    @days = editable
  end

  def new
    @opening_time = OpeningTime.new
    @days = sort_days
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

private

  def sort_days
    exclude = OpeningTime.all.map {|day| day.weekday}
    days = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)
    exclude.each {|x| days.delete(x)}
    days
  end

end