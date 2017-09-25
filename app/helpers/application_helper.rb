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
      { title: 'Mentors & Advisors, "Roster by Specialty - to see list click "Book It""',
        timeslot: 'Monday 9/25 - Friday 9/29: 11am-3pm',
        signup_url: 'https://docs.google.com/spreadsheets/d/e/2PACX-1vT-sHP3qtTXcm54cnKDd4DKcGPO9iKCGvvYqM_3kZx2JH-K3gqRBzubNaSfSaELEpgyK2U0heh1ApDz/pubhtml?gid=2083275987&single=true' },
      { title: 'Colleen Kazemi, "Founder, Growth, Marketing & Sales, Planning & Strategy, Talent & HR, Content Strategy", Pure Cultures',
        timeslot: 'Monday 9/25: 11a-1pm',
        signup_url: 'http://slottd.com/events/k7x5ymn3qx/slots' },
      { title: 'Carm Huntress, "Money, Investment, Funding", RxRevu',
        timeslot: 'Monday 9/25: 11-1pm',
        signup_url: 'http://slottd.com/events/pzt2g5vcn7/slots' },
        { title: 'Alice Warren-Gregory, "Founder, Legal, Planning & Strategy", Bold Legal, LLC',
        timeslot: 'Monday 9/25: 12-2pm',
        signup_url: 'http://slottd.com/events/nk61965wyj/slots' },
      { title: 'Adrienne Fischer, "Legal", Summit Law Solutions, LLC',
        timeslot: 'Monday 9/25: 12-1pm',
        signup_url: 'http://slottd.com/events/ob72nj95rd/slots' },
         { title: 'Sandro Sacerdoti, "Legal, Planning and Strategy", Bold Legal, LLC',
        timeslot: 'Monday 9/25: 1-2pm',
        signup_url: 'http://slottd.com/events/9r6h6galrl/slots' },
       { title: 'Clay Cousins, "Founder, Planning & Strategy, Talent & HR", Elevate Momentum',
        timeslot: 'Tuesday 9/26: 11-1pm',
        signup_url: 'http://slottd.com/events/u7ofp8drko/slots' },
      { title: 'Joshua Hunt, "Founder, Money, Investment, Funding, Real Estate", TRELORA',
        timeslot: 'Tuesday 9/26: 12-2pm',
        signup_url: 'http://slottd.com/events/jhwsg88pls/slots' },
       { title: 'Ryan Howell, "Legal", Rubicon Law',
        timeslot: 'Tuesday 9/26: 12-2pm',
        signup_url: 'http://slottd.com/events/pdneow23vj/slots' },
       { title: 'Donald Murphy, "Marketing & Sales, Planning & Strategy, Finding the correct Purpose Path way in your business", Project Purpose',
        timeslot: 'Tuesday 9/26: 1-2pm',
        signup_url: 'http://slottd.com/events/52qqovfvel/slots' },
         { title: 'UB Ciminieri, "Founder, Marketing & Sales, Talent & HR, Talent and Creative Strategy", Jobber Group',
        timeslot: 'Tuesday 9/26: 1-2pm',
        signup_url: 'http://slottd.com/events/y39xtxgci4/slots' },
       { title: 'Jessie Dixon, "Founder, Planning & Strategy, Operations", Havenly',
        timeslot: 'Wednesday 9/27: 11-1pm',
        signup_url: 'http://slottd.com/events/c4uu89nz6d/slots' },
         { title: 'Steve Hobbs, "Growth, Money, Investment, Funding, Planning & Strategy", NTL Management Systems',
        timeslot: 'Wednesday 9/27: 11-1pm',
        signup_url: 'http://slottd.com/events/znpghk2agk/slots' },
      { title: 'Noel Jorden, "Developer, Planning & Strategy, Product", GoSpotCheck',
        timeslot: 'Wednesday 9/27: 11:30-1:30pm',
        signup_url: 'http://slottd.com/events/xpggqvakpy/slots' },
       { title: 'Bob Ogdon, "Investment, Funding, Planning & Strategy", Swiftpage',
        timeslot: 'Wednesday 9/27: 12-2pm',
        signup_url: 'http://slottd.com/events/e9w8sgui9m/slots' },
         { title: 'Jack Wroldsen, "Legal, Money, Investment, Funding, Planning & Strategy", Bold Legal, LLC',
        timeslot: 'Wednesday 9/27: 12-2pm',
        signup_url: 'http://slottd.com/events/bhkl49xxaw/slots' },
        { title: 'Patrick Rea, "Funding, Planning & Strategy, Cannabis Industry", Canopy Builder',
        timeslot: 'Wednesday 9/27: 12-2pm',
        signup_url: 'http://slottd.com/events/rbbrrz4qku/slots' },
      { title: 'Andrew Comer, "Founder, Legal, Planning & Strategy", Ireland Stapleton Pryor & Pascoe, P.C.',
        timeslot: 'Wednesday 9/27: 12-2pm',
        signup_url: 'http://slottd.com/events/t4sreker4e/slots' },
      { title: 'Olivia Omega, "Founder, Marketing & Sales, Planning & Strategy", Wallace Marketing Group',
        timeslot: 'Wednesday 9/27: 12-2pm',
        signup_url: 'http://slottd.com/events/euo9ia94yr/slots' },
      { title: 'Shawn Wallace, "Founder, Marketing & Sales, Planning & Strategy", Wallace Marketing Group',
        timeslot: 'Wednesday 9/27: 12-2pm',
        signup_url: 'http://slottd.com/events/5wtjjqnla3/slots' },
        { title: 'Donald Murphy, "Marketing & Sales, Planning & Strategy,  Finding the correct Purpose Path way in your business", Project Purpose',
        timeslot: 'Wednesday 9/27: 1-2pm',
        signup_url: 'http://slottd.com/events/c1vhc9ulky/slots' },
          { title: 'Chris Runquist, "Money, Investment, Funding, Planning & Strategy, Accounting", Simple Startup',
        timeslot: 'Thursday 9/28: 11-1pm',
        signup_url: 'http://slottd.com/events/vjs47lggnk/slots' },
         { title: 'Manny Ladis, "Founder, Growth, Marketing & Sales", Dizzion',
        timeslot: 'Thursday 9/28: 11-1pm',
        signup_url: 'http://slottd.com/events/py2yvtvw8q/slots' },
       { title: 'Matt Craine, "Founder, Growth, Marketing & Sales, Planning & Strategy", mattcraine.com and Becoming 3D',
        timeslot: 'Thursday 9/28: 11-1pm',
        signup_url: 'http://slottd.com/events/xwz46hho24/slots' },
       { title: 'Ben Wright, "Founder, Growth, Marketing & Sales", Community Systems',
        timeslot: 'Thursday 9/28: 12-2pm',
        signup_url: 'http://slottd.com/events/fgswpbq6v2/slots' },
         { title: 'Brooke Hipp, "Marketing and Sales", ACM',
        timeslot: 'Thursday 9/28: 12-2pm',
        signup_url: 'http://slottd.com/events/8aajbi7pq4/slots' },
       { title: 'Erin Stadler, "Founder, Planning & Strategy, Product", Boomtown Accelerator',
        timeslot: 'Thursday 9/28: 12-2pm',
        signup_url: 'http://slottd.com/events/dphbfuwazv/slots' },
        { title: 'Craig Garby, "Legal", BOLD Legal, LLC',
        timeslot: 'Thursday 9/28: 12-1pm',
        signup_url: 'http://slottd.com/events/e1swcgrll7/slots' },
        { title: 'Sandro Sacerdoti, "Legal, Planning & Strategy", Bold Legal, LLC',
        timeslot: 'Thursday 9/28: 1-2pm',
        signup_url: 'http://slottd.com/events/smqdmd9f6s/slots' },
       { title: 'UB Ciminieri, "Founder, Marketing & Sales, Talent & HR", Jobber Group',
        timeslot: 'Thursday 9/28: 1-2pm',
        signup_url: 'http://slottd.com/events/ezh5fjezkf/slots' },
       { title: 'Dave Harris, "Marketing & Sales, Money, Investment, Funding, Planning & Strategy", Rockies Venture Fund',
        timeslot: 'Friday 9/29: 11-1pm',
        signup_url: 'http://slottd.com/events/lsz5qsabxv/slots' },
       { title: 'David Kendall, "Founder, Legal, Organizational Culture", Bold Legal, LLC',
        timeslot: 'Friday 9/29: 11-1pm',
        signup_url: 'http://slottd.com/events/7e752b1i58/slots' },
      { title: 'Nichole Montoya, "Investment, Funding, Planning & Strategy", Cheddar Up',
        timeslot: 'Friday 9/29: 11-1pm',
        signup_url: 'http://slottd.com/events/oscjdvy3i5/slots' },
        { title: 'Marla Riegel, "Growth, Planning & Strategy, Culture and Conflict Resolution", The Inspired Business Center',
        timeslot: 'Friday 9/29: 11-1pm',
        signup_url: 'http://slottd.com/events/nqs7m8c8oq/slots' },
        { title: 'Rich Piech, "Growth, Marketing & Sales", Sales Engineered Systems',
        timeslot: 'Friday 9/29: 11-12pm',
        signup_url: 'http://slottd.com/events/af5ustdpta/slots' },
       { title: 'Natty Zola, "Growth, Money, Investment", TechStars',
        timeslot: 'Friday 9/29: 1-2pm',
        signup_url: 'http://slottd.com/events/nenvpqamdg/slots' },
        { title: 'Terrance Carroll, "Legal, Money, Investment, Funding", Butler Snow LLP',
        timeslot: 'Friday 9/29: 1-2pm',
        signup_url: 'http://slottd.com/events/vf5y9q6vk4/slots' },
        { title: 'Rich Piech, "Growth, Marketing & Sales", Sales Engineered Systems',
        timeslot: 'Friday 9/29: 1-2pm',
        signup_url: 'http://slottd.com/events/lfwmplvbar/slots' }
    ]
  end

  def group_mentor_sessions
    [
      { title: 'Bryan Leach, Founder & CEO, Ibotta',
        timeslot: 'Monday 9/25: 11:00am-12:00pm',
        signup_url: 'https://www.denverstartupweek.org/schedule/3771-group-mentor-session-with-bryan-leach-founder-ceo-of-ibotta' },
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
       { title: 'Nancy Phillips, Founder & Executive Chair to the Board, ViaWest',
        timeslot: 'Thursday 9/28: 3:00pm-4:00pm',
        signup_url: 'https://www.denverstartupweek.org/schedule/3772-group-mentor-session-with-nancy-phillips-president-ceo-of-viawest' },
      { title: 'Linda Appel Lipsius, Co-Founder & CEO, Teatulia Organic Teas & The Mamahood',
        timeslot: 'Friday 9/29: 1:00pm-2:00pm',
        signup_url: 'https://www.denverstartupweek.org/schedule/3819-group-mentor-session-with-linda-appel-lipsius-co-founder-ceo-of-teatulia-organic-teas-the-mama-hood' },
       { title: 'Nicole Glaros, Chief Innovation Officer, Techstars',
        timeslot: 'Friday 9/29: 11:00am-12:00pm',
        signup_url: 'https://www.denverstartupweek.org/schedule/3840-group-mentor-session-with-nicole-glaros-chief-innovation-officer-techstars'},
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
                                for_sponsors_page.
                                alphabetical.
                                includes(:track, submission: :track).
                                group_by(&:level)
  end

  def ambassador_host_company_sponsorships
    @_ambassador_host_company_sponsorships ||= Sponsorship.
                                               for_current_year.
                                               where(level: Sponsorship::AMBASSADOR_HOST_LEVEL).
                                               alphabetical.
                                               includes(:track, submission: :track)
  end

  def ambassador_sponsorships
    @_ambassador_sponsorships ||= Sponsorship.
                                  for_current_year.
                                  where(level: Sponsorship::AMBASSADOR_SPONSOR_LEVEL).
                                  alphabetical.
                                  includes(:track, submission: :track)
  end

  def ambassador_partners
    @_ambassador_partners ||= Sponsorship.
                              for_current_year.
                              where(level: Sponsorship::AMBASSADOR_PARTNER_LEVEL).
                              alphabetical.
                              includes(:track, submission: :track)
  end
end
