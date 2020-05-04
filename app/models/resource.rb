class Resource < ApplicationRecord

  validates :name,
    length: {maximum: 150},
    presence: true

  validates :description,
    presence: true

  has_and_belongs_to_many :support_areas, validate: false

  belongs_to :user
  belongs_to :industry_type, required: false
  belongs_to :company

  mount_uploader :image, HeaderImageUploader
  process_in_background :image

  def to_param
    "#{id}-#{name.try(:parameterize)}"
  end

  def active?
    expiration_date.nil? || expiration_date > Date.today
  end

  def self.for_support_area(name)
    return all if name == "all" || name.blank?
    joins(:support_areas).where("LOWER(support_areas.name) = LOWER(?)", name)
  end

  def self.for_industry_type(name)
    return all if name == 'all' || name.blank?
    joins(:industry_types).where('LOWER(industry_types.name) = LOWER(?)', name)
  end

  def self.searchable_language
    "english"
  end

  def self.fulltext_search(terms)
    return all if terms.blank?
    predicate = {
      name: terms,
      description: terms,
      user: {name: terms},
    }
    left_outer_joins(:users).basic_search(predicate, false)
  end

  def related
    base_query = self.class.left_outer_joins(:support_areas)
    query = base_query.where(user_id: user_id)
    query = query.or(base_query.where(company_id: company_id)) if company.present?
    query = query.or(base_query.where(support_areas: {id: support_area_ids})) if support_area_ids.any?
    query = query.or(base_query.where(industry_type_id: industry_type_id)) if industry_type_id.present?

    query.where.not(id: id).distinct
  end

  def editable?
    false
  end
end
