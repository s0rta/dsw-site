class NewsroomItem < ApplicationRecord

  validates :title,
            :release_date, presence: true

  validates :attachment, presence: true, if: ->(ni) { ni.external_link.blank? }
  validates :external_link, presence: true, if: ->(ni) { ni.attachment.blank? }

  mount_uploader :attachment, PdfUploader

  def self.active
    where(is_active: true)
  end

  def title_with_date
    "#{title} (#{release_date.to_s(:long)})"
  end
end
