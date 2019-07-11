class Publishing < ApplicationRecord
  belongs_to :subject, polymorphic: true

  def self.filtered_results(filters)
    article_ids = Article.for_publishings_filter(filters).to_a.pluck(:id)
    session_ids = Submission.for_publishings_filter(filters).to_a.pluck(:id)
    where(subject_type: "Article", subject_id: article_ids)
      .or(where(subject_type: "Submission", subject_id: session_ids))
      .reorder("publishings.effective_at" => :desc)
      .includes(:subject)
  end

  def self.for_homepage
    where(featured_on_homepage: true)
  end
end
