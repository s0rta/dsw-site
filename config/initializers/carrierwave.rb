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

if Rails.env.test?

  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end

# make sure uploader is auto-loaded
  AvatarUploader

  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?
    klass.class_eval do
      def cache_dir
        '#{Rails.root}/spec/support/uploads/tmp'
      end

      def store_dir
        '#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}'
      end
    end
  end

end
