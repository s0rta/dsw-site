# Shim in Cloudinary support for the Cmsimple image uploader
Rails.application.config.after_initialize do
  ImageAttachmentUploader.send :include, Cloudinary::CarrierWave
end
