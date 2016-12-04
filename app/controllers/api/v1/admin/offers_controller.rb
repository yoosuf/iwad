class Api::V1::Admin::OffersController < ApplicationController




  private
    def set_offers
      @offer = Offer.find(params[:id])
    end

    def offer_params
      params.require(:offer).permit(:name, :start_date, :end_date, :description, :status)
    end
end
