module SearchableSubmission
  extend ActiveSupport::Concern

  included do
    scope :fulltext_search, Proc.new { |terms|
      if terms.present?
        predicate = {
          title: terms,
          description: terms,
          users: {
            name: terms
          }
        }
        joins(:submitter).basic_search(predicate, false)
      end
    }
  end

  class_methods do
    def searchable_language
      'english'
    end
  end
end
