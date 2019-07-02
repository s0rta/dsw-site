class Publishing < ApplicationRecord
  belongs_to :subject, polymorphic: true

  def self.filtered_results(filters)
    articles = Article.for_publishings_filter(filters)
    sessions = Submission.for_publishings_filter(filters)
    # searching gem seems to break pluck method, so explicitly turning results into an array
    ids = articles.to_a.pluck(:id) + sessions.to_a.pluck(:id)
    where(subject_id: ids).order(effective_at: :desc).includes(:subject)
  end
end
