class Api::V1::Admin::DeliveriesController < ApplicationController

  before_filter :set_delivery, only: [:show, :update]
  respond_to :json

  def index
    @deliveries = Delivery.all
    respond_with @deliveries
  end

  def show
    render :json => @delivery
  end

  def create

  end

  def update

  end



  private
    def set_delivery
      @delivery = Delivery.find(params[:id])
    end

    def delivery_params
      params.require(:delivery).permit(:name, :start_date, :end_date, :description, :status)
    end

end
