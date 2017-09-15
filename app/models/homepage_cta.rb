# frozen_string_literal: true

class HomepageCta < ApplicationRecord

  self.table_name = 'homepage_ctas'

  validates :title,
            :subtitle,
            :body,
            :link_text,
            :link_href, presence: true

  validates :title,
            :subtitle,
            :body, liquid: true

  validates :priority,
            numericality: { only_integer: true }

  validates :relevant_to_cycle,
            inclusion: { in: EventSchedule::CYCLES,
                         allow_blank: true }

  belongs_to :track, optional: true

  def self.active
    where(is_active: true)
  end

  def self.in_priority_order
    order('CASE WHEN track_id <> null THEN 0 ELSE 1 END DESC, priority DESC')
  end

  def self.relevant_to_cycles(cycles)
    if cycles.any?
      where(relevant_to_cycle: nil).
        or(where(relevant_to_cycle: '')).
        or(where(relevant_to_cycle: cycles))
    else
      where(relevant_to_cycle: nil).
        or(where(relevant_to_cycle: ''))
    end
  end
end
