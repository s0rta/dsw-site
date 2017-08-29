class PopulateCompanies < ActiveRecord::Migration[5.1]
  def up
    add_index :companies,
              'lower(name) varchar_pattern_ops',
              name: 'index_companies_on_lower_name_unique',
              unique: true
    Submission.reset_column_information
    Submission.find_each do |s|
      company_name = s.attributes['company_name']
      next if company_name.blank?
      clean_company_name = company_name.gsub(/,?\s*(?:llc|inc|ltd)\.?/i, '').strip
      company = Company.where('LOWER(name) = LOWER(?)', clean_company_name).first_or_create!(name: clean_company_name)
      s.update_column :company_id, company.id
    end

    Registration.reset_column_information
    Registration.find_each do |r|
      company_name = r.attributes['company_name']
      next if company_name.blank?
      clean_company_name = company_name.gsub(/,?\s*(?:llc|inc|ltd)\.?/i, '').strip
      company = Company.where('LOWER(name) = LOWER(?)', clean_company_name).first_or_create!(name: clean_company_name)
      r.update_column :company_id, company.id
    end
  end

  def down
    Submission.update_all(company_id: nil)
    Registration.update_all(company_id: nil)
  end
end
