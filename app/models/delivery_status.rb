class DeliveryStatus < ActiveRecord::Base
  def self.getAllASJson
    @deliverStatuses = []
    DeliveryStatus.all().each do |status|
      @deliverStatuses << status.as_json(nil)
    end
    return @deliverStatuses
  end
end
