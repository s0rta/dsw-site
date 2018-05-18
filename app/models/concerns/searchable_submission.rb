module SearchableSubmission
  extend ActiveSupport::Concern

  class_methods do
    def searchable_language
      'english'
    end

    def fulltext_search(terms)
      if terms.present?
        predicate = {
          title: terms,
          description: terms,
          users: { name: terms },
          companies_for_search: { name: terms }
        }
        joins(:submitter)
          .joins('LEFT OUTER JOIN companies companies_for_search ON companies_for_search.id = submissions.company_id')
          .basic_search(predicate, false)
      else
        all
      end
    end
  end

end
