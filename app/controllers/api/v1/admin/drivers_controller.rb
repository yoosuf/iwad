class Api::V1::Admin::DriversController < ApplicationController

  before_filter :set_driver, only: [:show, :update]

  def index
    @drivers = Driver.all
    render :json => @drivers
  end

  def show
    render :json => @driver
  end

  def create
  end

  def update
  end


  private
    def set_driver
      @driver = Driver.find(params[:id])
    end

    def delivery_params
      params.require(:driver).permit(:name, :start_date, :end_date, :description, :status)
    end

end
