class Admin::DeliveriesController < AdminController

  before_action :set_delivery, only: [:show, :edit, :update, :cancel]

  # GET Delivery Index method
  def index
    if params[:q].nil? || params[:q].empty?
      @deliveries =  Delivery.paginate(:page => params[:page], :per_page => 20).where('(delivery_date IS NULL AND delivery_status_id < 5) OR (delivery_date IS NOT NULL AND delivery_status_id >= 1 AND  delivery_status_id < 5)').order("created_at DESC")
    else

        if params[:option] == "id"
        
            @deliveries = Delivery.joins(:user)
                .paginate(:page => params[:page], :per_page => 20)
                .where("deliveries.id = ? ", "#{params[:q]}")
                .order("created_at DESC")
        
        elsif params[:option] == "org"
        
            @deliveries = Delivery.joins(:user)
            .paginate(:page => params[:page], :per_page => 20)
            .where("users.organisation_name LIKE ?", "%#{params[:q]}%")
            .order("created_at DESC")
            
        elsif params[:option] == "user"
            @deliveries = Delivery.joins(:user)
            .paginate(:page => params[:page], :per_page => 20)
            .where("users.name LIKE ?", "%#{params[:q]}%")
            .order("created_at DESC")

        elsif params[:option] == "cost"
        
            @deliveries = Delivery.joins(:user)
            .paginate(:page => params[:page], :per_page => 20)
            .where("deliveries.cost LIKE ?", "%#{params[:q]}%")
            .order("created_at DESC")

        elsif params[:option] == "to"
        
            @deliveries = Delivery.joins(:user)
            .paginate(:page => params[:page], :per_page => 20)
            .where("deliveries.to_location LIKE ?", "%#{params[:q]}%")
            .order("created_at DESC")

        elsif params[:option] == "contact"

            @deliveries = Delivery.joins(:user)
            .paginate(:page => params[:page], :per_page => 20)
            .where("deliveries.name LIKE ? OR deliveries.email LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
            .order("created_at DESC")

        elsif params[:option] == "driver"
        
            @deliveries = Delivery.joins(:user, :driver)
            .paginate(:page => params[:page], :per_page => 20)
            .where("drivers.first_name LIKE ? OR drivers.surname LIKE ?  OR drivers.email LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
            .order("created_at DESC")
            
        end

    end
  end

  def later
    if params[:keyword].nil? || params[:keyword].empty?
      @deliveries =  Delivery.paginate(:page => params[:page], :per_page => 20).where('delivery_date IS NOT NULL AND delivery_status_id < 1 ').order("created_at DESC")
    else

    @deliveries = Delivery.joins([:user])
          .paginate(:page => params[:page], :per_page => 20)
          .where("delivery_status_id < 1 AND delivery_date IS NOT NULL AND users.organisation_name LIKE ? OR users.name LIKE ? OR cost LIKE ? OR to_location LIKE ? OR deliveries.name LIKE ? OR deliveries.email  LIKE ?", "#{params[:keyword]}%", "#{params[:keyword]}%", "#{params[:keyword]}%", "#{params[:keyword]}%", "#{params[:keyword]}%", "#{params[:keyword]}%")
          .order("created_at DESC")

    end
  end


  def completed
    if params[:keyword].nil? || params[:keyword].empty?
      @deliveries =  Delivery.paginate(:page => params[:page], :per_page => 20).where('delivery_status_id = 5').order("created_at DESC")
    else

    @deliveries = Delivery.joins([:user])
          .paginate(:page => params[:page], :per_page => 20)
          .where("delivery_status_id = 5 AND delivery_date IS NOT NULL AND users.organisation_name LIKE ? OR users.name LIKE ? OR cost LIKE ? OR to_location LIKE ? OR deliveries.name LIKE ? OR deliveries.email  LIKE ?", "#{params[:keyword]}%", "#{params[:keyword]}%", "#{params[:keyword]}%", "#{params[:keyword]}%", "#{params[:keyword]}%", "#{params[:keyword]}%")
          .order("created_at DESC")

    end
  end


  def abendand
    if params[:keyword].nil? || params[:keyword].empty?
      @deliveries =  Delivery.paginate(:page => params[:page], :per_page => 20).where('delivery_status_id = 6').order("created_at DESC")
    else

    @deliveries = Delivery.joins([:user])
          .paginate(:page => params[:page], :per_page => 20)
          .where("delivery_status_id = 6 AND delivery_date IS NOT NULL AND users.organisation_name LIKE ? OR users.name LIKE ? OR cost LIKE ? OR to_location LIKE ? OR deliveries.name LIKE ? OR deliveries.email  LIKE ?", "#{params[:keyword]}%", "#{params[:keyword]}%", "#{params[:keyword]}%", "#{params[:keyword]}%", "#{params[:keyword]}%", "#{params[:keyword]}%")
          .order("created_at DESC")

    end
  end


  # GET Delivery Show method
  def show
  end

  # GET Delivery Edit method
  def edit
  end

  # GET View Delivery Allocation method
  def allocation
    @allocations =  DriverAllocation.paginate(:page => params[:page], :per_page => 20).where('delivery_id=?', params[:id]).order("created_at DESC")
  end

  # PUT/PATCH Update Delivery method
  def update
    @delivery.update(delivery_params)
    redirect_to admin_deliveries_path
  end

  def cancel
    @delivery.setCancellation
    redirect_to admin_deliveries_path
  end


  private
    def set_delivery
      @delivery = Delivery.find(params[:id])
    end

    def delivery_params
      params.require(:delivery).permit(:name, :start_date, :end_date, :description, :status)
    end
end
