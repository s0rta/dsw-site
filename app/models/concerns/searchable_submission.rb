module SearchableSubmission
  extend ActiveSupport::Concern

  included do
    include AlgoliaSearch
    algoliasearch per_environment: true, if: :indexable? do
      attribute :title, :description
      attribute(:track_name) { track.name }
    end
  end

  def indexable?
    for_current_year? && public?
  end
end
