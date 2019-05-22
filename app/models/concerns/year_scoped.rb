module YearScoped
  extend ActiveSupport::Concern

  included do
    validates :year, presence: true, format: %r(\A\d{4}\z)
    after_initialize do
      self.year ||= Date.today.year
    end
  end

  class_methods do
    def for_year(year)
      if year
        where(":table.year = :year", table: table_name, year: year)
      else
        for_current_year
      end
    end

    def for_current_year
      where(":table.year = :year", table: table_name, year: Date.today.year)
    end

    def for_previous_years
      where(":table.year < :year", table: table_name, year: Date.today.year)
    end
  end

  def for_current_year?
    year == Date.today.year
  end
end
