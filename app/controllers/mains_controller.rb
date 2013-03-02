#Main controller (admin root view)
class MainsController < ApplicationController
  before_filter :authenticate_user!

  def index

  end

end
