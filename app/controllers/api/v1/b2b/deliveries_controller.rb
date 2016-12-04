class Api::V1::B2b::DeliveriesController < UserApiController

  before_action :set_delivery, only: [:show]


  api :GET, '/v1/deliveries'
  formats ['json']
  description <<-EOS
      == Long description
       Get the list of deliveries related to your account as
       identified by the X-Auth-Token
    EOS
  def index
    alldDelveries = []

    @deliveries = Delivery.paginate(:page => params[:page], :per_page => params[:per_page]).reverse_order!.where('user_id =?', @current_user.id ).each do |delivery|
      alldDelveries << delivery.getJSON(nil)
    end

    render :json => {:success => :true , :deliveries => alldDelveries}
  end

  api :GET, '/v1/deliveries/:id'
  formats ['json']
  param :id, Fixnum, :desc => "Delivery Id", :required => true
  description <<-EOS
      == Long description
       Get the list of deliveries related to your account as
       identified by the X-Auth-Token
    EOS
  def show
    if @delivery
      render :json => {:success => :true , :delivery => @delivery.getJSON(nil)}
    else
      render :json => {:success => :false , :errors => ['You dont have delivery details']}, status: 404
    end
  end

  api :POST, '/v1/deliveries/'
  formats ['json']
  param :delivery, Hash, :desc => 'Delivery params' do
    param :name, String, :desc => "User name", :required => true
    param :from_location, String, :desc => "From address", :required => true
    param :from_lon, String, :desc => "From longitude", :required => true
    param :from_lat, String, :desc => "From latitude", :required => true
    param :from_door_number, String, :desc => "From door number", :required => true
    param :to_location, String, :desc => "To address / Delivery address", :required => true
    param :to_lat, String, :desc => "Latitude of delivery address", :required => true
    param :to_lon, String, :desc => "Delivery address longitude", :required => true
    param :to_door_number, String, :desc => "Delivery address door number", :required => true
    param :delivery_contact, String, :desc => "Delivery contact number", :required => true
    param :delivery_vehicle_id, String, :desc => "Delivery vehicle id", :required => true
    param :delivery_number, String, :desc => "Delivery number", :required => true
    param :driver_id, String, :desc => "Id of the driver", :required => true
    param :cost, String, :desc => "Cost of the ride", :required => true
    param :no_of_people, String, :desc => "Number of people in the ride", :required => true
  end
  description <<-EOS
      == Long description
       Get the list of deliveries related to your account as
       identified by the X-Auth-Token
    EOS
  def create
    if params[:token]
      if doPayment(params[:delivery][:cost], params[:token])
        Delivery.resetAllocations()

        delivery                    = Delivery.new(delivery_params)
        delivery.user_id            = @current_user.id
        delivery.delivery_status_id = 1

        if delivery.driver_id != 0
          delivery.manual = 1
          delivery.delivery_status_id = 2
        end

        delivery.setUpdatedTime

        if delivery.save
          current_user.decreaseCount
          render :json => {:success => :true , :delivery => delivery.getJSON({site_url: AppSetting.site_url })}
        else
          render :json => {:success => :true , :errors => delivery.errors.full_messages}, status: 422
        end
      else
        render :json => {:success => :true , :errors => ['Error with payment. Please try again']}, status: 422
      end
    else
      Delivery.resetAllocations()

      delivery                    = Delivery.new(delivery_params)
      delivery.user_id            = @current_user.id
      delivery.delivery_status_id = 1

      if delivery.driver_id != 0
        delivery.manual = 1
        delivery.delivery_status_id = 2
      end

      delivery.setUpdatedTime
      if delivery.save
        current_user.decreaseCount

        render :json => {:success => :true , :delivery => delivery.getJSON({site_url: AppSetting.site_url })}
      else
        render :json => {:success => :true , :errors => delivery.errors.full_messages}, status: 422
      end
    end
  end

  def doPayment(amount, token)
    Stripe.api_key = "sk_test_EsnRYa8jIaiqXknaEhl0CO6L"

    charge =  amount.to_i * 100

    @response = Stripe::Charge.create(
      :amount => charge.to_i ,
      :currency => "gbp",
      :source => token,
      :metadata => {'order_id' => '6735'}
    )

    return @response['status'] == 'succeeded'
  end

  private

    def set_delivery
      @delivery = Delivery.find(params[:id])
    end

    def delivery_params
      params.require(:delivery).permit(:name, :email, :from_location, :to_location, :delivery_date, :from_lat, :from_lon,:to_lat, :to_lon, :delivery_vehicle_id, :cost, :no_of_people, :driver_id, :note, :to_door_number, :from_door_number,:delivery_number, :delivery_contact, :cost, :delivery_status_id, :delivery_type)
    end
end
