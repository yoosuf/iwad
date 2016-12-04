class Admin::OffersController < AdminController

  before_action :set_offers, only: [:show, :edit, :update, :destroy]

  def index
    if params[:keyword].nil? || params[:keyword].empty?
      @offers  = Offer.paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
    else
      @offers  = Offer.paginate(:page => params[:page], :per_page => 20).where('name LIKE (?) OR description LIKE (?)',"%#{params[:keyword]}%","%#{params[:keyword]}%").order("created_at DESC")
    end
  end



  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    if @offer.valid?
      @offer.save
      redirect_to admin_offers_path
    else
      render 'new'
    end


  end

  def show
  end

  def edit
  end

  def update
    @offer.update(offer_params)
    redirect_to admin_offers_path
  end

  def destroy
    @offer.destroy
    redirect_to admin_offers_path
  end

  private
    def set_offers
      @offer = Offer.find(params[:id])
    end

    def offer_params
      params.require(:offer).permit(:name, :start_date, :end_date, :description, :status)
    end
end
