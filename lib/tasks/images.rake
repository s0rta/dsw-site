namespace :images do
  task recreate: :environment do
    [
      Article,
      Track,
      Cluster,
    ].each do |klass|
      klass.where.not(header_image: nil).each do |k|
        k.process_header_image_upload = true
        k.header_image.recreate_versions!
      end
    end

    Sponsorship.where.not(logo: nil).each do |s|
      s.process_logo_upload = true
      s.logo.recreate_versions!
    end

    User.where.not(avatar: nil).each do |u|
      u.process_avatar_upload = true
      u.avatar.recreate_versions!
    end
  end
end
