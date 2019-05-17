class Company < ApplicationRecord
  validates :name, presence: true,
                   uniqueness: {case_sensitive: true}

  has_many :registrations, dependent: :restrict_with_error
  has_many :submissions, dependent: :restrict_with_error
  has_many :venues, dependent: :restrict_with_error
  has_and_belongs_to_many :users

  def self.combine!(*companies)
    winner, *rest = companies
    transaction do
      rest.each do |loser|
        loser.submissions.update_all(company_id: winner.id)
        loser.registrations.update_all(company_id: winner.id)
        loser.destroy!
      end
    end
  end
end
