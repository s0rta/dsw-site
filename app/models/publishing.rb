class Publishing < ApplicationRecord
  validates :effective_at, presence: true
  belongs_to :subject, polymorphic: true

  def self.filtered_results(filters)
    article_ids = Article.for_publishings_filter(filters).reorder(nil).except(:select).select(:id)
    session_ids = Submission.for_publishings_filter(filters).reorder(nil).except(:select).select(:id)
    where(subject_type: "Article", subject_id: article_ids)
      .or(where(subject_type: "Submission", subject_id: session_ids))
      .reorder("publishings.effective_at" => :desc)
      .includes(:subject)
  end

  def self.for_homepage
    where(featured_on_homepage: true).includes(:subject).order(effective_at: :desc).limit(12)
  end

  def self.for_track(track_name)
    filtered_results(track: track_name).reorder(Arel.sql(<<-SQL))
      (CASE WHEN publishings.pinned_to_track THEN 1 ELSE 0 END) DESC,
      effective_at DESC
    SQL
  end
end
