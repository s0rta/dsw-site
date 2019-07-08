module PrimaryCalloutsHelper
  def primary_callout_ctas
   HomepageCta
    .active
    .relevant_to_cycles(AnnualSchedule.active_cycles)
    .in_priority_order
    .limit(3)
  end
end
