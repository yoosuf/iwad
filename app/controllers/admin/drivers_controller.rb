class Admin::DriversController < AdminController

  def index
    if params[:q].nil? || params[:q].empty?
      @drivers  = Driver.paginate(:page => params[:page], :per_page => 20).where('status = 1 AND is_delete = 0').order("created_at DESC")
    else
    
    
        if params[:option] == "id"
            
            @drivers  = Driver
            .joins(:delivery_vehicle)
            .paginate(:page => params[:page], :per_page => 20)
            .where("drivers.id = ?","#{params[:q]}")
            .order("created_at DESC")
            
        elsif params[:option] == "name"
        
            @drivers  = Driver
            .joins(:delivery_vehicle)
            .paginate(:page => params[:page], :per_page => 20)
            .where('drivers.first_name LIKE (?) OR drivers.middle_name LIKE (?) OR drivers.surname LIKE (?)',"%#{params[:q]}%","%#{params[:q]}%","%#{params[:q]}%")
            .order("created_at DESC")
        
        elsif params[:option] == "email"
        
            @drivers  = Driver
            .joins(:delivery_vehicle)
            .paginate(:page => params[:page], :per_page => 20)
            .where('drivers.email = ?',"#{params[:q]}")
            .order("created_at DESC")
            

        elsif params[:option] == "vehicle"

            @drivers  = Driver
            .joins(:delivery_vehicle)
            .paginate(:page => params[:page], :per_page => 20)
            .where('delivery_vehicles.name LIKE (?)', "%#{params[:q]}%")
            .order("created_at DESC")
            
        end



    end
  end



  def map
    @allAvailableDrivers = DriverLocation.allDrivers()
    @hash = Gmaps4rails.build_markers(@allAvailableDrivers) do |userLocation, marker|
      marker.lat userLocation.lat
      marker.lng userLocation.lon
      marker.picture({
        'url'   => view_context.image_url(userLocation.driver_status_id == 1 ? 'availableDriver.png' :'unavailableDriver.png'),
        'width' => 50,
        'height'=> 50
         })
      marker.infowindow  render_to_string( partial: 'marker_info', locals: { userLocation: userLocation})
    end
  end





  def pending_list
    if params[:keyword].nil? || params[:keyword].empty?
      @drivers  = Driver.paginate(:page => params[:page], :per_page => 20).where('status = 0').order("created_at DESC")
    else
      @drivers  = Driver.paginate(:page => params[:page], :per_page => 20).where('status = 0 AND (first_name LIKE (?) OR middle_name LIKE (?) OR surname LIKE (?) OR email LIKE (?))',"%#{params[:keyword]}%","%#{params[:keyword]}%","%#{params[:keyword]}%","%#{params[:keyword]}%").order("created_at DESC")
    end
  end


  def suspend_list
    if params[:keyword].nil? || params[:keyword].empty?
      @drivers  = Driver.paginate(:page => params[:page], :per_page => 20).where('is_delete = 1').order("created_at DESC")
    else
      @drivers  = Driver.paginate(:page => params[:page], :per_page => 20).where('is_delete = 1 AND (first_name LIKE (?) OR middle_name LIKE (?) OR surname LIKE (?) OR email LIKE (?))',"%#{params[:keyword]}%","%#{params[:keyword]}%","%#{params[:keyword]}%","%#{params[:keyword]}%").order("created_at DESC")
    end
  end

  def verify
    @driver = Driver.find(params[:id])
    @driver.status = 1
    @driver.save

    redirect_to pending_list_admin_drivers_path
  end

  def report
    @driver = Driver.find(params[:driver_id])
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "report"
      end
    end
  end

  def edit
    @driver = Driver.find(params[:id])
  end

  def show
    @driver = Driver.find(params[:id])
  end

  def update
    @driver = Driver.find(params[:id])

    if @driver.update(driver_params)
      redirect_to admin_drivers_path
    else
      render :template => 'admin/drivers/edit'
    end

  end

  def driver_params
    params.require(:driver).permit(:is_delete)

  end
end
