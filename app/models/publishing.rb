class Publishing < ApplicationRecord
  belongs_to :subject, polymorphic: true

  def self.filtered_results(filters)
    article_ids = Article.for_publishings_filter(filters).select(:id)
    session_ids = Submission.for_publishings_filter(filters).select(:id)
    where(subject_type: "Article", id: article_ids)
      .or(where(subject_type: "Submission", id: session_ids))
      .reorder("publishings.effective_at" => :desc)
      .includes(:subject)
  end
end
