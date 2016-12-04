class Admin::ReportsController < AdminController
  def index


    if params[:type].nil?

      respond_to do |format|
        format.html
        format.csv { send_data @deliveries.to_csv, filename: "deliveries-#{Date.today}.csv" }
      end


    else

      
      if params[:type] == "daily"  && params[:organisation] && params[:date]
        @deliveries = Delivery.joins([:user]).where("users.organisation_name = ? AND DATE(deliveries.created_at) = ?", params[:organisation], params[:date] ).all
      elsif params[:type] == "monthly" && params[:organisation] && params[:start_date] && params[:end_date]
        @deliveries = Delivery.joins([:user]).where("users.organisation_name = ? AND  DATE(deliveries.created_at)  >= ? AND DATE(deliveries.created_at) <= ?", params[:organisation], params[:start_date], params[:end_date]).all
      end
      



      respond_to do |format|
        format.html
        format.csv { send_data @deliveries.to_csv, filename: "deliveries-#{Date.today}.csv" }
      end
      
    end



    


  end




end
