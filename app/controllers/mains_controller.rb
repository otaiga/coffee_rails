#Main controller (admin root view)
class MainsController < ApplicationController
  before_filter :authenticate_user!

  def index
    #TODO - Show prize status (on/off) - updatable.
    #TODO - Update/create prize.

  end

end
