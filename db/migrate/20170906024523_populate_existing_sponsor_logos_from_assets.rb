class PopulateExistingSponsorLogosFromAssets < ActiveRecord::Migration[5.1]
  def up
    Sponsorship.reset_column_information
    Sponsorship.find_each do |s|
      logo_asset = s.attributes['logo']
      logo_asset_path = "redesign/sponsors/#{logo_asset}"
      next unless logo_asset.present?
      path = if Rails.application.assets
        Rails.application.assets.find_asset(logo_asset_path).filename
      else
        "public/assets/#{Rails.application.assets_manifest.assets[logo_asset_path]}"
      end
      Rails.logger.info "Setting logo for #{s.name} to #{logo_asset} from #{path}"
      s.logo = File.open(path)
      s.save(validate: false)
    end
  end

  def down
    raise ActiveRecord::IreversibleMigration
  end
end
