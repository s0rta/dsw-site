# if Rails.env.test?
#   CarrierWave.configure do |config|
#     config.enable_processing = false
#   end
# end

require 'carrierwave/storage/fog'

if ENV['AWS_ACCESS_KEY_ID'] &&
   ENV['AWS_SECRET_ACCESS_KEY'] &&
   ENV['CARRIERWAVE_UPLOADS_S3_BUCKET'] &&
   ENV['CARRIERWAVE_UPLOADS_CDN_HOST']

  Rails.logger.info 'Using Carrierwave with Fog/AWS storage'

  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }
    config.fog_directory  = ENV['CARRIERWAVE_UPLOADS_S3_BUCKET']
    config.fog_attributes = { cache_control: "public, max-age=#{1.year.to_i}" }
    config.asset_host = ENV['CARRIERWAVE_UPLOADS_CDN_HOST']
  end
else
  Rails.logger.info 'Using Carrierwave with local file storage'
  CarrierWave.configure do |config|
    config.storage = :file
  end
end
