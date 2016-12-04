class DeliveryMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.delivery_mailer.cancellation.subject
  #
  def cancellation(delivery)
    @delivery = delivery
    emails = []
    if mail(to: emails, subject: "[DEVELOPMENT] iWAD Delivery #{@delivery.id} on the loop!")

      Rails.logger.info("EMAIL SENT FROM BACKGROUND")

    end



  end
end
