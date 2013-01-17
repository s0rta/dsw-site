# Shim in Cloudinary support for the Cmsimple image uploader
require 'cmsimple'
require 'cloudinary'
Cmsimple::ImageAttachmentUploader.send :include, Cloudinary::CarrierWave
