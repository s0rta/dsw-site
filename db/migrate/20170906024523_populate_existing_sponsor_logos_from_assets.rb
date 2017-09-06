class PopulateExistingSponsorLogosFromAssets < ActiveRecord::Migration[5.1]
  def up
    Sponsorship.reset_column_information
    Sponsorship.find_each do |s|
      logo_asset = s.attributes['logo']
      next unless logo_asset.present?
      path = Rails.application.assets.find_asset("redesign/sponsors/#{logo_asset}").filename
      Rails.logger.info "Setting logo for #{s.name} to #{logo_asset} from #{path}"
      s.logo = File.open(path)
      s.save(validate: false)
    end
  end

  def down
    raise ActiveRecord::IreversibleMigration
  end
end
