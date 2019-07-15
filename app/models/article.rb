class Article < ApplicationRecord
  include ValidatedVideoUrl
  include Publishable

  validates :title,
    length: {maximum: 150},
    presence: true

  validates :body,
    presence: true

  has_and_belongs_to_many :tracks, validate: false
  has_many :authorships, dependent: :destroy
  has_many :authors, class_name: "User", through: :authorships, source: :user

  belongs_to :submitter, class_name: "User"
  belongs_to :submission, required: false
  belongs_to :company, required: false

  mount_uploader :header_image, HeaderImageUploader

  accepts_nested_attributes_for :publishing, allow_destroy: true
  accepts_nested_attributes_for :authorships, allow_destroy: true

  def to_param
    "#{id}-#{title.try(:parameterize)}"
  end

  def self.for_publishings_filter(filters)
    return all if filters.blank?

    for_track(filters[:track])
      .for_cluster(filters[:cluster])
      .fulltext_search(filters[:terms])
  end

  def self.for_track(name)
    return all if name == "all" || name.blank?
    joins(:tracks).where("LOWER(tracks.name) = LOWER(?)", name)
  end

  def self.for_cluster(name)
    all # until clusters reference is added to articles
    # return all if name == 'all' || name.blank?
    # joins(:clusters).where('LOWER(clusters.name) = LOWER(?)', name)
  end

  def self.searchable_language
    "english"
  end

  def self.fulltext_search(terms)
    return all if terms.blank?
    predicate = {
      title: terms,
      body: terms,
      users: {name: terms},
    }
    left_outer_joins(:authors).basic_search(predicate, false)
  end

  def self.published
    joins(:publishing).where("effective_at <= ?", Time.zone.now)
  end

  def related
    base_query = self.class.left_outer_joins(:tracks, :authors)
    query = base_query.where(submitter_id: submitter_id)
    query = query.or(base_query.where(company_id: company_id)) if company.present?
    query = query.or(base_query.where(tracks: {id: track_ids})) if track_ids.any?
    query = query.or(base_query.where(users: {id: author_ids})) if author_ids.any?

    query.published.where.not(id: id).distinct
  end

  def editable?
    false
  end
end
