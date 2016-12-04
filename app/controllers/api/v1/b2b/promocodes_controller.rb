class Api::V1::B2b::PromocodesController < UserApiController

  api :GET, '/v1/b2b/promo_codes/', 'Fetch all available promo codes'
  formats ['json']
  description <<-EOS
      == Long description
    EOS
  def index
    promocodes = []

    @deliveries = Promocode.all().each do |promocode|
      promocodes << promocode.as_json(nil)
    end

    render :json => {:success => :true , :promocodes => promocodes}
  end
end
