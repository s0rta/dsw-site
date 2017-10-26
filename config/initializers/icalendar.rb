require 'tzinfo'
require 'icalendar'
require 'icalendar/tzinfo'

require 'new_relic/agent/method_tracer'
Icalendar::Calendar.class_eval do
  include ::NewRelic::Agent::MethodTracer

  add_method_tracer :to_ical, 'Custom/Icalendar::Calendar#to_ical'
end  
