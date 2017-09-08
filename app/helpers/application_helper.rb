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
      { title: 'Colleen Kazemi, "Founder, Growth, Marketing & Sales, Planning & Strategy, Talent & HR, Content Strategy", Pure Cultures',
        timeslot: 'Monday 9/25: 11-1pm',
        signup_url: 'http://slottd.com/events/k7x5ymn3qx/slots' },
      { title: 'Carm Huntress, "Money, Investment, Funding", Pure Cultures',
        timeslot: 'Monday 9/25: 11-1pm',
        signup_url: 'http://slottd.com/events/pzt2g5vcn7/slots' },
      { title: 'Natty Zola, "Growth, Money, Investment", TechStars',
        timeslot: 'Monday 9/25: 11-12pm',
        signup_url: 'http://slottd.com/events/bp21wurfrr/slots' },
        { title: 'Alice Warren-Gregory, "Founder, Legal, Planning & Strategy", Bold Legal, LLC',
        timeslot: 'Monday 9/25: 12-2pm',
        signup_url: 'http://slottd.com/events/nk61965wyj/slots' },
       { title: 'Paul Foley, "Founder, Growth, Marketing & Sales", Connector Capital',
        timeslot: 'Monday 9/25: 12-2pm',
        signup_url: 'http://slottd.com/events/hoo5l4jakn/slots' },
      { title: 'Adrienne Fischer, "Legal", Summit Law Solutions, LLC',
        timeslot: 'Monday 9/25: 12-1pm',
        signup_url: 'http://slottd.com/events/ob72nj95rd/slots' },
       { title: 'Lindsey Laurain, Marketing & Sales, Planning & Strategy, Product", ezpz',
        timeslot: 'Monday 9/25: 1-2pm',
        signup_url: 'http://slottd.com/events/i2nn9kpuc7/slots' },
       { title: 'Clay Cousins, "Founder, Planning & Strategy, Talent & HR", Elevate Momentum',
        timeslot: 'Tuesday 9/26: 11-1pm',
        signup_url: 'http://slottd.com/events/u7ofp8drko/slots' },
       { title: 'Josie Hosmer, "Growth, Legal, Money, Investment, Funding, Planning & Strategy", Meyer Law, Rockies Venture Club',
        timeslot: 'Tuesday 9/26: 11-1pm',
        signup_url: 'http://slottd.com/events/mh9ly8utol/slots' },
        { title: 'Matthew Erley, "Growth, Marketing & Sales", Havenly',
        timeslot: 'Tuesday 9/26: 11-1pm',
        signup_url: 'http://slottd.com/events/bj5zwk8lts/slots' },
       { title: 'Tony Blank, "Founder, Growth, Planning & Strategy", SendGrid',
        timeslot: 'Tuesday 9/26: 11-1pm',
        signup_url: 'http://slottd.com/events/4p9n3b4cm4/slots' },
       { title: 'Josh Anderson, "Planning & Strategy, Talent & HR", Patriot Boot Camp presented by Techstars',
        timeslot: 'Tuesday 9/26: 11-12pm',
        signup_url: 'http://slottd.com/events/43x3bwalpi/slots' },
        { title: 'Dave DuPont, "Marketing & Sales, Planning & Strategy, Talent & HR", TeamSnap',
        timeslot: 'Tuesday 9/26: 11:30-1:30pm',
        signup_url: 'http://slottd.com/events/q8k3ve66ho/slots' },
       { title: 'Sonu Kansal, "Product", Trueffect',
        timeslot: 'Tuesday 9/26: 11:30-1:30pm',
        signup_url: 'http://slottd.com/events/wmi5ny6q7u/slots' },
       { title: 'Stephan Reckie, "Growth, Marketing & Sales, Money", Angelus Funding',
        timeslot: 'Tuesday 9/26: 11-2pm',
        signup_url: 'http://slottd.com/events/wrbcjycq9h/slots' },
       { title: 'Grace Oliva, "Money, Investment, Funding", Colorado Impact Fund',
        timeslot: 'Tuesday 9/26: 11:30-1:30pm',
        signup_url: 'http://slottd.com/events/67i4xpwin9/slots' },
      { title: 'Joshua Hunt, "Founder, Money, Investment, Funding, Real Estate", TRELORA',
        timeslot: 'Tuesday 9/26: 12-2pm',
        signup_url: 'http://slottd.com/events/jhwsg88pls/slots' },
       { title: 'Ryan Howell, "Legal", Rubicon Law',
        timeslot: 'Tuesday 9/26: 12-2pm',
        signup_url: 'http://slottd.com/events/pdneow23vj/slots' },
       { title: 'Barbara Bauer, "Funding, Planning & Strategy, Talent & HR", Rockies Venture Club',
        timeslot: 'Tuesday 9/26: 1-2pm',
        signup_url: 'http://slottd.com/events/vnuwvnk7a6/slots' },
       { title: 'Donald Murphy, "Marketing & Sales, Planning & Strategy, Finding the correct Purpose Path way in your business", Project Purpose',
        timeslot: 'Tuesday 9/26: 1-2pm',
        signup_url: 'http://slottd.com/events/52qqovfvel/slots' },
         { title: 'UB Ciminieri, "Founder, Marketing & Sales, Talent & HR, Talent and Creative Strategy", Jobber Group',
        timeslot: 'Tuesday 9/26: 1-2pm',
        signup_url: 'http://slottd.com/events/ezh5fjezkf/slots' },
       { title: 'Cory Finney, "Founder, Money, Investment, Funding, Planning & Strategy", Boomtown / Kokopelli Capital',
        timeslot: 'Wednesday 9/27: 11-1pm',
        signup_url: 'http://slottd.com/events/27hfvgpdx7/slots' },
       { title: 'Jessie Dixon, "Founder, Planning & Strategy, Operations", Havenly',
        timeslot: 'Wednesday 9/27: 11-1pm',
        signup_url: 'http://slottd.com/events/c4uu89nz6d/slots' },
         { title: 'Steve Hobbs, "Growth, Money, Investment, Funding, Planning & Strategy", NTL Management Systems',
        timeslot: 'Wednesday 9/27: 11-1pm',
        signup_url: 'http://slottd.com/events/znpghk2agk/slots' },
        { title: 'Aaron Stachel, "Investment, Funding, Planning & Strategy", PV Ventures',
        timeslot: 'Wednesday 9/27: 11-12pm',
        signup_url: 'http://slottd.com/events/jzbxsiq3fh/slots' },
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
       { title: 'Peter Adams, "Investment, Funding, Planning & Strategy", Rockies Venture Club',
        timeslot: 'Wednesday 9/27: 12-2pm',
        signup_url: 'http://slottd.com/events/9bg8sjucru/slots' },
      { title: 'Andrew Comer, "Founder, Legal, Planning & Strategy", Ireland Stapleton Pryor & Pascoe, P.C.',
        timeslot: 'Wednesday 9/27: 12-2pm',
        signup_url: 'http://slottd.com/events/t4sreker4e/slots' },
      { title: 'Olivia Omega, "Founder, Marketing & Sales, Planning & Strategy", Wallace Marketing Group',
        timeslot: 'Wednesday 9/27: 12-2pm',
        signup_url: 'http://slottd.com/events/euo9ia94yr/slots' },
      { title: 'Shawn Wallace, "Founder, Marketing & Sales, Planning & Strategy", Wallace Marketing Group',
        timeslot: 'Wednesday 9/27: 12-2pm',
        signup_url: 'http://slottd.com/events/5wtjjqnla3/slots' },
       { title: 'Aaron Stachel, "Investment, Funding, Planning & Strategy", PV Ventures',
        timeslot: 'Wednesday 9/27: 1-2pm',
        signup_url: 'http://slottd.com/events/a5a7yhdk8v/slots' },
         { title: 'Manny Ladis, "Founder, Growth, Marketing & Sales", Dizzion',
        timeslot: 'Thursday 9/28: 11-1pm',
        signup_url: 'http://slottd.com/events/py2yvtvw8q/slots' },
       { title: 'Matt Craine, "Founder, Growth, Marketing & Sales, Planning & Strategy", mattcraine.com and Becoming 3D',
        timeslot: 'Thursday 9/28: 11-1pm',
        signup_url: 'http://slottd.com/events/xwz46hho24/slots' },
        { title: 'Josh Anderson, "Planning & Strategy, Talent & HR", Patriot Boot Camp presented by Techstars',
        timeslot: 'Thursday 9/28: 11-12pm',
        signup_url: 'http://slottd.com/events/utk79chnnn/slots' },
         { title: 'Brooke Hipp, "Marketing and Sales", ACM',
        timeslot: 'Thursday 9/28: 12-2pm',
        signup_url: 'http://slottd.com/events/8aajbi7pq4/slots' },
          { title: 'LJ Suzuki, "Growth, Money, Investment, Funding, Planning & Strategy", CFOshare',
        timeslot: 'Thursday 9/28: 12-2pm',
        signup_url: 'http://slottd.com/events/gr16ysoz21/slots' },
         { title: 'Paul Allen, "Founder, Marketing & Sales, Money, Investment, Funding", Paul Allen Group',
        timeslot: 'Thursday 9/28: 12-2pm',
        signup_url: 'http://slottd.com/events/y63zmrotkz/slots' },
        { title: 'Craig Garby, "Legal", BOLD Legal, LLC',
        timeslot: 'Thursday 9/28: 12-1pm',
        signup_url: 'http://slottd.com/events/e1swcgrll7/slots' },
       { title: 'Catherine Compitello, "Investment, Funding, Planning & Strategy", Selt',
        timeslot: 'Thursday 9/28: 1-2pm',
        signup_url: 'http://slottd.com/events/a5e1fbqnse/slots' },
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
        { title: 'Karyn Miller, "Funding, Planning & Strategy, Talent & HR", Craftsy',
        timeslot: 'Friday 9/29: 12-2pm',
        signup_url: 'http://slottd.com/events/thqxvv92fd/slots' },
       { title: 'Travis Ladue, "Designer", Studio Mast',
        timeslot: 'Friday 9/29: 12-2pm',
        signup_url: 'http://slottd.com/events/rgchfrcyb9/slots' },
       { title: 'Linda Appel Lipsius, "Marketing & Sales, Planning & Strategy, Product", Teatulia',
        timeslot: 'Friday 9/29: 1-2pm',
        signup_url: 'http://slottd.com/events/retogmyden/slots' },
        { title: 'Natty Zola, "Growth, Money, Investment", TechStars',
        timeslot: 'Friday 9/29: 1-2pm',
        signup_url: 'http://slottd.com/events/nenvpqamdg/slots' },
        { title: 'Rich Piech, "Growth, Marketing & Sales", Sales Engineered Systems',
        timeslot: 'Friday 9/29: 1-2pm',
        signup_url: 'http://slottd.com/events/lfwmplvbar/slots' },
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
