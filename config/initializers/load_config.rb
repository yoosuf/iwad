require 'ostruct'

custom_config = OpenStruct.new(YAML.load_file("#{Rails.root}/config/config.yml"))
::AppSetting = OpenStruct.new(custom_config.send(Rails.env))
