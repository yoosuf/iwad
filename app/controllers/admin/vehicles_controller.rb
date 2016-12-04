class Admin::VehiclesController < AdminController
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]

  # GET /admin/vehicles
  # GET /admin/vehicles.json
  def index
    @vehicles = DeliveryVehicle.all
  end

  # GET /admin/vehicles/1
  # GET /admin/vehicles/1.json
  def show
  end

  # GET /admin/vehicles/new
  def new
    @vehicle = DeliveryVehicle.new
  end

  # GET /admin/vehicles/1/edit
  def edit
  end

  # POST /admin/vehicles
  # POST /admin/vehicles.json
  def create
    @vehicle = DeliveryVehicle.new(vehicle_params)

    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to @vehicle, notice: 'Vehicle was successfully created.' }
        format.json { render :show, status: :created, location: @vehicle }
      else
        format.html { render :new }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/vehicles/1
  # PATCH/PUT /admin/vehicles/1.json
  def update
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to @vehicle, notice: 'Vehicle was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_vehicle }
      else
        format.html { render :edit }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/vehicles/1
  # DELETE /admin/vehicles/1.json
  def destroy
    @vehicle.destroy
    respond_to do |format|
      format.html { redirect_to admin_vehicles_url, notice: 'Vehicle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = DeliveryVehicle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vehicle_params
      params.fetch(:vehicle, {})
    end
end
