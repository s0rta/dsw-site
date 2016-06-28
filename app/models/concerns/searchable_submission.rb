module SearchableSubmission
  extend ActiveSupport::Concern

  class_methods do
    def searchable_language
      'english'
    end

    def searchable_columns
      %i(title description)
    end

    def fulltext_search(terms)
      if terms.present?
        basic_search(terms)
      else
        all
      end
    end
  end

end
