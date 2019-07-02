class Article < ApplicationRecord
  validates :title,
    length: {maximum: 150},
    presence: true

  validates :body,
    presence: true

  has_and_belongs_to_many :tracks, validate: false
  has_many :authorships, dependent: :destroy
  has_many :authors, class_name: "User", through: :authorships, source: :user
  has_one :publishing, as: :subject

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
    return all if name == 'all' || name.blank?
    joins(:tracks).where('LOWER(tracks.name) = LOWER(?)', name)
  end

  def self.for_cluster(name)
    return all # until clusters reference is added to articles
    # return all if name == 'all' || name.blank?
    # joins(:clusters).where('LOWER(clusters.name) = LOWER(?)', name)
  end

  def self.searchable_language
    'english'
  end

  def self.fulltext_search(terms)
    return all if terms.blank?
    predicate = {
      title: terms,
      body: terms,
      users: { name: terms }
    }
    joins(:authors).basic_search(predicate, false)
  end
end
