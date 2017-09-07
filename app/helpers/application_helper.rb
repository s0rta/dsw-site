module ApplicationHelper

  def process_with_liquid(content)
    context = {
      'submission_close_date' => EventSchedule::SUBMISSION_CLOSE_DATE,
      'voting_close_date' => EventSchedule::VOTING_CLOSE_DATE,
      'current_date' => DateTime.now
    }
    template = Liquid::Template.parse(content)
    template.render(context)
  end

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

  def time_remaining_to_deadline(deadline_date)
    days = ((deadline_date.at_end_of_day - Time.zone.now) / 1.day)
    full_days = days.floor
    hours = (days - full_days) * 24
    full_hours = hours.floor
    minutes = (hours - full_hours) * 60
    full_minutes = minutes.floor
    "#{full_days} : #{full_hours.to_s.rjust(2, "0")} : #{full_minutes.to_s.rjust(2, "0")}"
  end

  def tracks_for_select
    Track.submittable.in_display_order.map { |t| [ t.name, t.id ] }
  end

  def clusters_for_select
    Cluster.in_display_order.map { |c| [ c.name, c.id ] }
  end

  def age_ranges_for_select
    Registration::AGE_RANGES
  end

  def mentor_sessions
    [
      { title: 'Carm Huntress, "Money, Investment, Funding", Pure Cultures',
        timeslot: 'Monday 9/25: 11-1pm',
        signup_url: 'http://slottd.com/events/pzt2g5vcn7/slots' },
      { title: 'Natty Zola, "Growth, Money, Investment", TechStars',
        timeslot: 'Monday 9/25: 11-12pm',
        signup_url: 'http://slottd.com/events/bp21wurfrr/slots' },
      { title: 'Adrienne Fischer, "Legal", Summit Law Solutions, LLC',
        timeslot: 'Monday 9/25: 12-1pm',
        signup_url: 'http://slottd.com/events/ob72nj95rd/slots' },
       { title: 'Lindsey Laurain, Marketing & Sales, Planning & Strategy, Product", ezpz',
        timeslot: 'Monday 9/25: 1-2pm',
        signup_url: 'http://slottd.com/events/i2nn9kpuc7/slots' },
       { title: 'Sonu Kansal, "Product", Trueffect',
        timeslot: 'Tuesday 9/26: 11-2pm',
        signup_url: 'http://slottd.com/events/wmi5ny6q7u/slots' },
       { title: 'Dave DuPont, "Marketing & Sales, Planning & Strategy, Talent & HR", TeamSnap',
        timeslot: 'Tuesday 9/26: 11-1pm',
        signup_url: 'http://slottd.com/events/q8k3ve66ho/slots' },
       { title: 'Stephan Reckie, "Growth, Marketing & Sales, Money", Angelus Funding',
        timeslot: 'Tuesday 9/26: 11-2pm',
        signup_url: 'http://slottd.com/events/wrbcjycq9h/slots' },
       { title: 'Barbara Bauer, "Funding, Planning & Strategy, Talent & HR", Rockies Venture Club',
        timeslot: 'Tuesday 9/26: 1-2pm',
        signup_url: 'http://slottd.com/events/vnuwvnk7a6/slots' },
       { title: 'Donald Murphy, "Marketing & Sales, Planning & Strategy, Finding the correct Purpose Path way in your business", Project Purpose',
        timeslot: 'Tuesday 9/26: 1-2pm',
        signup_url: 'http://slottd.com/events/52qqovfvel/slots' },
        { title: 'Aaron Stachel, "Investment, Funding, Planning & Strategy", PV Ventures',
        timeslot: 'Wednesday 9/27: 11-12pm',
        signup_url: 'http://slottd.com/events/jzbxsiq3fh/slots' },
       { title: 'Bob Ogdon, "Investment, Funding, Planning & Strategy", Swiftpage',
        timeslot: 'Wednesday 9/27: 12-2pm',
        signup_url: 'http://slottd.com/events/e9w8sgui9m/slots' },
       { title: 'Peter Adams, "Investment, Funding, Planning & Strategy", Rockies Venture Club',
        timeslot: 'Wednesday 9/27: 12-2pm',
        signup_url: 'http://slottd.com/events/9bg8sjucru/slots' },
       { title: 'Aaron Stachel, "Investment, Funding, Planning & Strategy", PV Ventures',
        timeslot: 'Wednesday 9/27: 1-2pm',
        signup_url: 'http://slottd.com/events/a5a7yhdk8v/slots' },
       { title: 'Patrick Rea, "Funding, Planning & Strategy, Cannabis Industry", Canopy Builder',
        timeslot: 'Wednesday 9/27: 12-2pm',
        signup_url: 'http://slottd.com/events/rbbrrz4qku/slots' },
       { title: 'Nichole Montoya, "Investment, Funding, Planning & Strategy", Cheddar Up',
        timeslot: 'Friday 9/29: 11-1pm',
        signup_url: 'http://slottd.com/events/oscjdvy3i5/slots' },
       { title: 'Travis Ladue, "Designer", Studio Mast',
        timeslot: 'Friday 9/29: 12-2pm',
        signup_url: 'http://slottd.com/events/rgchfrcyb9/slots' },
       { title: 'Karyn Miller, "Funding, Planning & Strategy, Talent & HR", Craftsy',
        timeslot: 'Friday 9/29: 12-2pm',
        signup_url: 'http://slottd.com/events/thqxvv92fd/slots' },
       { title: 'Linda Appel Lipsius, "Marketing & Sales, Planning & Strategy, Product", Teatulia',
        timeslot: 'Friday 9/29: 1-2pm',
        signup_url: 'http://slottd.com/events/retogmyden/slots' },
        { title: 'Natty Zola, "Growth, Money, Investment", TechStars',
        timeslot: 'Friday 9/29: 1-2pm',
        signup_url: 'http://slottd.com/events/nenvpqamdg/slots' },
      { title: 'More Sessions Coming Soon!',
        timeslot: 'TBA',
        signup_url: '' },
    ]
  end

  def group_mentor_sessions
    [
      { title: 'Bryan Leach, Founder & CEO, Ibotta',
        timeslot: 'Monday 9/25: 11:00am-12:00pm',
        signup_url: 'https://www.denverstartupweek.org/schedule/3771-group-mentor-session-with-bryan-leach-founder-ceo-of-ibotta' },
      { title: 'Jackie Ros, Co-Founder & CCO, Revolar',
        timeslot: 'Monday 9/25: 1:30pm-2:30pm',
        signup_url: 'https://www.denverstartupweek.org/schedule/3774-group-mentor-session-with-jackie-ros-co-founder-cco-of-revolar' },
      { title: 'Kimbal Musk, Co-Founder, The Kitchen',
        timeslot: 'Monday 9/25: 3:30pm-4:00pm',
        signup_url: 'https://www.denverstartupweek.org/schedule/3773-group-mentor-session-with-kimbal-musk-co-founder-of-the-kitchen' },
      { title: 'Sameer Dholakia, CEO, SendGrid',
        timeslot: 'Tuesday 9/26: 10:00am-11:00am',
        signup_url: 'https://www.denverstartupweek.org/schedule/3776-group-mentor-session-with-sameer-dholakia-ceo-of-sendgrid' },
      { title: 'Justin Cucci, Composer & Chef, Edible Beats',
        timeslot: 'Tuesday 9/26: 2:00pm-3:00pm',
        signup_url: 'https://www.denverstartupweek.org/schedule/3775-group-mentor-session-with-justin-cucci-composer-chef-edible-beats' },
      { title: 'Lee Mayer, Co-Founder & CEO, Havenly',
        timeslot: 'Tuesday 9/26: 3:00pm-4:00pm',
        signup_url: 'https://www.denverstartupweek.org/schedule/3777-group-mentor-session-with-lee-mayer-co-founder-ceo-of-havenly' },
      { title: 'Ryan Kirkpatrick, Partner, CO Impact Fund',
        timeslot: 'Wednesday 9/27: 10:00am-11:00am',
        signup_url: 'https://www.denverstartupweek.org/schedule/3778-group-mentor-session-with-ryan-kirkpatrick-partner-at-colorado-impact-fund' },
       { title: 'Nancy Phillips, Founder & President, ViaWest',
        timeslot: 'Thursday 9/28: 2:00pm-3:00pm',
        signup_url: 'https://www.denverstartupweek.org/schedule/3772-group-mentor-session-with-nancy-phillips-president-ceo-of-viawest' },
    ]
  end

  def basecamp_sessions
    Submission.
      for_current_year.
      for_schedule.
      joins(:track).
      where(tracks: { name: 'Basecamp' })
  end

  def sponsorships_by_level
    @_sponsorships_by_level ||= Sponsorship.
                                for_current_year.
                                alphabetical.
                                includes(:track, submission: :track).
                                group_by(&:level)
  end
end
