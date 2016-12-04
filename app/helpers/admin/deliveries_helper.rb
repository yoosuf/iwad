module Admin::DeliveriesHelper
  ##
  ## Signature name
  ##
  def signature_name(name)

    if name.nil?
      ''
    else
      name
    end
  end

  ##
  ## Date time format for the Deliveries section
  ##
  def date_format(date)
    if date.nil?
      ''
    else
      date.strftime("%d - %m - %Y %I:%M %p")
    end
  end


  ##
  ## Signature file
  ##
  def signature_file(signature)
    if signature.nil?
      ''
    else

      image_tag('//' +request.host + "/assets/deliveries/signature/#{@delivery.id}/original/#{signature}", :style => "height: 200px;  width: 50%;")
    end

  end

end
