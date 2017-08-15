class PopulateSubmissionHours < ActiveRecord::Migration[4.2]
  def up
    Submission.all.each do |s|
      next unless s.time_range.present?
      start_hour = case s.time_range
      when 'Breakfast'
        8
      when 'Early morning'
        9
      when 'Morning'
        11
      when 'Lunch'
        12
      when 'Early afternoon'
        13
      when 'Afternoon'
        15
      when 'Happy hour'
        17
      when 'Evening'
        18
      when 'Late night'
        22
      end
      s.update_column :start_hour, start_hour
      s.update_column :end_hour, start_hour + 2
    end
  end

  def down
  end
end
