class Developers::PagesController < ApplicationController

  before_action :authenticate_diver!, :except => [:index]
  layout "blank", only: [:index]

  def index
  end

  def api
  end
end
