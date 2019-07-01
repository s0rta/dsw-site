class Publishing < ApplicationRecord
  belongs_to :subject, polymorphic: true

  def self.filtered_results(filters)
    articles = Article.for_publishings_filter(filters)
    sessions = []
    if AnnualSchedule.registration_open? || AnnualSchedule.post_week?
      sessions = Submission.for_publishings_filter(filters)
    end
    ids = articles.pluck(:id) + sessions.pluck(:id)

    where(subject_id: ids)
    .order(effective_at: :desc)
  end
end
