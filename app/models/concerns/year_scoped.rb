module YearScoped
  extend ActiveSupport::Concern

  included do
    after_initialize do
      self.year ||= Date.today.year
    end
  end

  class_methods do

    def for_year(year)
      if year
        where(year: year)
      else
        for_current_year
      end
    end

    def for_current_year
      where(year: Date.today.year)
    end

    def for_previous_years
      where('year < ? ', Date.today.year)
    end
  end

  def for_current_year?
    year == Date.today.year
  end
end
