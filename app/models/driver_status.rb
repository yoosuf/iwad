class DriverStatus < ActiveRecord::Base

  def self.getAllASJson
    @deliverStatuses = []

    DriverStatus.all().each do |status|
      @deliverStatuses << status.as_json(nil)
    end

    return @deliverStatuses
  end
end
