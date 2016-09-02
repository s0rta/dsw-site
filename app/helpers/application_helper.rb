module ApplicationHelper
  def process_with_pipeline(content)
    context = {
      asset_root: "/images/icons"
    }
    pipeline = HTML::Pipeline.new([
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::EmojiFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::AutolinkFilter
    ], context)
    result = pipeline.call content
    result[:output].html_safe
  end

  def current_year
    Date.today.year
  end

  def time_remaining_to_deadline(deadline_str)
    Time.use_zone('Mountain Time (US & Canada)') do
      deadline_date =  (Time.zone.parse(deadline_str) + 1.day).at_midnight
      days = ((deadline_date - Time.zone.now) / 1.day)
      full_days = days.floor
      hours = (days - full_days) * 24
      full_hours = hours.floor
      minutes = (hours - full_hours) * 60
      full_minutes = minutes.floor
      "#{full_days} : #{full_hours.to_s.rjust(2, "0")} : #{full_minutes.to_s.rjust(2, "0")}"
    end
  end

  def tracks_for_select
    Track.submittable.in_display_order.map { |t| [ t.name, t.id ] }
  end

  def volunteer_shifts_for_select
    VolunteerShift.for_select
  end

  def age_ranges_for_select
    Registration::AGE_RANGES
  end

  def mentor_sessions
    [
      { title: 'Adam Schlegel, EatDenver', timeslot: 'Monday 9/12: 9-11am', signup_url: 'http://slottd.com/events/tv98le5rg9/slots' },
      { title: 'Desi McAdam, Nanno', timeslot: 'Monday 9/12: 9-11am', signup_url: 'http://slottd.com/events/iotnz6ihol/slots' },
      { title: 'Bo Brustkern, NSR Invest', timeslot: 'Monday 9/12: 9-11am', signup_url: 'http://slottd.com/events/ogl7htrpga/slots' },
      { title: 'David Uhlig, Summit 6 Legal', timeslot: 'Monday 9/12: 9-11am', signup_url: 'http://slottd.com/events/z4ex4opurh/slots' },
      { title: 'Rich Kopcho, Cray Burrough', timeslot: 'Monday 9/12: 9-11am', signup_url: 'http://slottd.com/events/a8pp4hailj/slots' },
      { title: 'David Schachter, Fennemore Craig, P.C.', timeslot: 'Tuesday 9/13: 9-11am', signup_url: 'http://slottd.com/events/aj1ki2ygi4/slots' },
      { title: 'Jason Lewis, Ecospace', timeslot: 'Tuesday 9/13: 9-11am', signup_url: 'http://slottd.com/events/3ykzwzdue4/slots' },
      { title: 'Ryan Howell, Rubicon Law', timeslot: 'Tuesday 9/13: 9-11am', signup_url: 'http://slottd.com/events/jkrbodjfj3/slots' },
      { title: 'Mindy Nies, Nies Design', timeslot: 'Tuesday 9/13: 9-11am', signup_url: 'http://slottd.com/events/rk9hyt2x2u/slots' },
      { title: 'Karyn Miller, Craftsy', timeslot: 'Tuesday 9/13: 9-11am', signup_url: 'http://slottd.com/events/1s44r42url/slots' },
      { title: 'Aaron  Stachel, PV Ventures', timeslot: 'Tuesday 9/13: 9-11am', signup_url: 'http://slottd.com/events/bv299obxu2/slots' },
      { title: 'David Eichler, Decibel Blue ', timeslot: 'Tuesday 9/13: 9-11am', signup_url: 'http://slottd.com/events/n3nzql26p7/slots' },
      { title: 'Manny Ladis, Dizzion', timeslot: 'Tuesday 9/13: 9-11am', signup_url: 'http://slottd.com/events/lj6lzhoag1/slots' },
      { title: 'Elizabeth Worthington, EA Worthington', timeslot: 'Tuesday 9/13: 9-11am', signup_url: 'http://slottd.com/events/ss3qthcc6g/slots' },
      { title: 'Sonu Kansal, Trueffect', timeslot: 'Tuesday 9/13: 9-11am', signup_url: 'http://slottd.com/events/k28pmjlr5i/slots' },
      { title: 'Carlyn Williams, Cooley', timeslot: 'Tuesday 9/13: 9-11am', signup_url: 'http://slottd.com/events/o3oxtl655i/slots' },
      { title: 'Joe Zell, Grotech Ventures', timeslot: 'Wednesday 9/14: 9-11am', signup_url: 'http://slottd.com/events/gn1der5hps/slots' },
      { title: 'Kirk Holland, Access Venture Partners', timeslot: 'Wednesday 9/14: 9-11am', signup_url: 'http://slottd.com/events/o56gvsz2xp/slots' },
      { title: 'Stephan Reckie, Angelus Funding', timeslot: 'Wednesday 9/14: 9-11am', signup_url: 'http://slottd.com/events/klhairngep/slots' },
      { title: 'Andrew Fischer, Choozle', timeslot: 'Wednesday 9/14: 9-11am', signup_url: 'http://slottd.com/events/twvskl3v4n/slots' },
      { title: 'Joshua Hunt, TRELORA', timeslot: 'Wednesday 9/14: 9-11am', signup_url: 'http://slottd.com/events/s82fawlgss/slots' },
      { title: 'Carm Huntress, RxREVU, Inc.', timeslot: 'Wednesday 9/14: 9-11am', signup_url: 'http://slottd.com/events/jewlhz4e1x/slots' },
      { title: 'Perry Evans, Closely Inc.', timeslot: 'Wednesday 9/14: 9-11am', signup_url: 'http://slottd.com/events/3ho7p2no9m/slots' },
      { title: 'Amy Baglan, MeetMindful', timeslot: 'Wednesday 9/14: 9-11am', signup_url: 'http://slottd.com/events/lln3shuez1/slots' },
      { title: 'Alex Kreilein, SecureSet', timeslot: 'Wednesday 9/14: 9-11am', signup_url: 'http://slottd.com/events/n45de7drlq/slots' },
      { title: 'Jose Vieitez, Boomtown', timeslot: 'Wednesday 9/14: 9-11am', signup_url: 'http://slottd.com/events/vhs2e7l99g/slots' },
      { title: 'Rich Grote, TravelPort', timeslot: 'Wednesday 9/14: 9-11am', signup_url: 'http://slottd.com/events/yb99m9vt2h/slots' },
      { title: 'Marc Nager, TVA', timeslot: 'Wednesday 9/14: 9-11am', signup_url: 'http://slottd.com/events/tiwoidynpg/slots' },
      { title: 'Patrick Rea, Canopy', timeslot: 'wednesday 9/14: 9-11am', signup_url: 'http://slottd.com/events/f4ifvzfryv/slots' },
      { title: 'Global Accelerator Network', timeslot: 'Wednesday 9/14: 9-11am', signup_url: 'http://slottd.com/events/u35enutr5f/slots' },
      { title: 'Terry Pratchett, Chase', timeslot: 'Wednesday 9/14: 9-11am', signup_url: 'http://slottd.com/events/oq3q7wiom6/slots' },
      { title: 'Joel Jacobson, Rubicon Law', timeslot: 'Thursday 9/15: 9-11am', signup_url: 'http://slottd.com/events/f4tr25gbhz/slots' },
      { title: 'Paul Foley, Augur', timeslot: 'Thursday 9/15: 9-11am', signup_url: 'http://slottd.com/events/1qcqdr2tjp/slots' },
      { title: 'Shelby Burford, Shelby Burford | Marketplace Storytelling', timeslot: 'Thursday 9/15: 9-11am', signup_url: 'http://slottd.com/events/x6x5gaa46w/slots' },
      { title: 'Matt Craine, Becoming 3D & mattcraine.com', timeslot: 'Thursday 9/15: 9-11am', signup_url: 'http://slottd.com/events/t9nkesit1c/slots' },
      { title: 'Julie Penner, Techstars', timeslot: 'Thursday 9/15: 9-11am', signup_url: 'http://slottd.com/events/eipr765r81/slots' },
      { title: 'Natty Zola, Techstars', timeslot: 'Thursday 9/15: 9-11am', signup_url: 'http://slottd.com/events/624wv6ly4p/slots' },
      { title: 'Olivia Omega Wallace, Wallace Marketing Group', timeslot: 'Thursday 9/15: 9-11am', signup_url: 'http://slottd.com/events/f4kaoecl9a/slots' },
      { title: 'Tricia Meyer, Meyer Law, Ltd.', timeslot: 'Thursday 9/15: 9-11am', signup_url: 'http://slottd.com/events/w2kepck2yy/slots' },
      { title: 'Rachel Russell, Colorado Lending Source', timeslot: 'Thursday 9/15: 9-11am', signup_url: 'http://slottd.com/events/83q4548uya/slots' },
      { title: 'Davin Burke, XYMotion', timeslot: 'Thursday 9/15: 9-11am', signup_url: 'http://slottd.com/events/z852gtdmhd/slots' },
      { title: 'Matt Cassell, Bank SNB', timeslot: 'Thursday 9/15: 9-11am', signup_url: 'http://slottd.com/events/wfts83rnf1/slots' },
      { title: 'Joe Coleman, Chase', timeslot: 'Thursday 9/15: 9-11am', signup_url: 'http://slottd.com/events/sgo6vhjmwc/slots' },
    ]
  end

  def bizdev_sessions
    [
      { title: 'HomeAdvisor', timeslot: 'Monday 9/12: 2:30-4pm', signup_url: 'http://slottd.com/events/f9256ejikx/slots' },
      { title: 'Zayo Group', timeslot: 'Monday 9/12: 2:30-4pm', signup_url: 'http://slottd.com/events/pxe8mwl29r/slots' },
      { title: 'Charter Communications', timeslot: 'Tueday 9/13: 2:30-4pm', signup_url: 'http://slottd.com/events/w8iqck9qzo/slots' },
      { title: 'Charter Communications', timeslot: 'Wednesday 9/14: 2:30-4pm', signup_url: 'http://slottd.com/events/d5w5irdf2c/slots' },
      { title: 'Twitter', timeslot: 'Wednesday 9/14: 2:30-4pm', signup_url: 'http://slottd.com/events/h19nlsc8o9/slots' },
      { title: 'DaVita', timeslot: 'Thursday 9/15: 2:30-4pm', signup_url: 'http://slottd.com/events/374xrbebbu/slots' },
      { title: 'Avnet', timeslot: 'Thursday 9/15: 2:30-4pm', signup_url: 'http://slottd.com/events/9td32t11hg/slots' }
    ]
  end
end
