# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Track.reset_column_information
{
  'Founder' => {
    icon: 'person',
    color: 'orange',
    is_submittable: true,
    description: <<-EOF.strip_heredoc.squish
    Whether you're just dreaming about starting a business, on your first, or a seasoned entrepreneur,
    the founder track will provide you with the skills and knowledge you need to found a company. Initial
    product development, go-to-market strategies, finding funding, and building a team are just some of the
    topics that are covered. Start down the path of creating your startup!
    EOF
  },
  'Growth' => {
    icon: 'chart',
    color: 'blue',
    is_submittable: true,
    description: <<-EOF.strip_heredoc.squish
    No matter how good it is, no product sells itself. A team that markets, sells, and supports the product
    well is a huge advantage for any startup. Every aspect of digital marketing, inbound and outbound sales,
    and customer experience is going to be covered at Denver Startup Week. Growing a startup depends on these
    skills, don't miss your chance to improve them!
    EOF
  },
  'Designer' => {
    icon: 'eyeball',
    color: 'green',
    is_submittable: true,
    description: <<-EOF.strip_heredoc.squish
    Seeing things others do not see is an art and our design track is packed with creative outlets to expand your
    thinking and ability to design.  From fashion to architecture to breakout digital design and artwork – the
    design track is focused on the critical elements of design. Learn new skills, hear from those responsible for
    some of the best projects in Colorado, and let your creative juices flow. Enjoy connecting with fellow design
    leaders and leave the week with fresh inspiration!
    EOF
  },
  'Product' => {
    icon: 'phone',
    color: 'purple',
    is_submittable: true,
    description: <<-EOF.strip_heredoc.squish
    Product management, development, and marketing, all different sides of the same coin that somehow bridges the gap
    between building the product and delivering it to the market. Product skills are in huge demand but there aren't
    very many places where you can go to acquire them. Come improve your product game at Denver Startup Week!
    EOF
  },
  'Developer' => {
    icon: 'terminal',
    color: 'gold',
    is_submittable: true,
    description: <<-EOF.strip_heredoc.squish
    Frontend, backend, full stack, big data, APIs, architecture, methodologies, junior, senior, we have it all. Learn
    new technologies, refine your skills, or just check out something completely different. Walk away a better engineer
    than you were before!
    EOF
  },
  'Maker' => {
    icon: 'wrench',
    color: 'teal',
    is_submittable: true,
    description: <<-EOF.strip_heredoc.squish
    Encompasses all physical products for every type of maker under the sun - from outdoor rec, distilling (or brewing!),
    and crafting, to connected devices, open-source hardware, 3D printing, and IOT (just to name a few) - join us to hear
    stories behind breakout brands, learn about new technologies in manufacturing, and connect other artisans, engineers,
    manufacturers and enterprises!
    EOF
  },
  'Headline Events' => {
    icon: 'star',
    color: 'headline-session',
    is_submittable: true,
    description: <<-EOF.strip_heredoc.squish
    Drawing together members of the community across the boundaries of industry, job function, and background, our Headline
    Events provide entertaining and interesting content, unique perspectives, and a forum for our community to connect and share ideas.
    EOF
  },
  'Basecamp' => {
    icon: 'basecamp',
    color: 'basecamp-session',
    is_submittable: false,
  },
  'Social Events' => {
    icon: 'martini',
    color: 'red',
    is_submittable: false,
  }
}.each do |track_name, attrs|
  t = Track.where(name: track_name).first_or_initialize

  # Skip if the record has been updated since it was populated
  next if t.updated_at && t.updated_at > t.created_at

  t.assign_attributes(attrs)
  t.save!
end

Cluster.reset_column_information
{
  'IoT' => {
    description: <<-EOF.strip_heredoc.squish
    From smart devices to integrated homes to intelligent vehicles, the Internet of Things is rapidly transforming the
    way that we interact with the world around us. Check out the latest technologies and trends in the IoT realm, and
    take a look behind the scenes at what it takes to concept, design and build a connected product.
    EOF
  },
  'Diversity & Inclusion' => {
    description: <<-EOF.strip_heredoc.squish
    Building an inclusive organization and culture is a critical part of any early-stage company, particularly in a
    world of increasingly global and diverse customer bases. Explore the what, how and why of building a diverse team,
    and hear firsthand the experiences of those on the front lines enabling diversity in the startup realm.
    EOF
  },
  'Cannabis' => {
    description: <<-EOF.strip_heredoc.squish
    Colorado is at the forefront not only of entrepreneurship and technology, but also in the emerging cannabis industry.
    Beyond just the leaf, explore the intersection of technology and cannabis, how these two seemingly different fields
    interoperate, and the challenges of building a company at the intersection of emerging markets and regulatory frameworks.
    EOF
  },
  'Healthtech' => {
    description: <<-EOF.strip_heredoc.squish
    As healthcare costs continue to rise, individuals and companies find themselves in an increasingly unstable economic
    situation. Enter digital health technologies, exploding on the scene with engaging, low-cost, and convenient tools
    that will have a lasting impact on large populations both here in Colorado and throughout the country.\n\nExplore the
    significant transformations coming to, and already being implemented in, the healthcare industry from both technologists
    and healthcare professionals. Plus, see the technological innovations that could be making a real difference in your
    own health care in the near future
    EOF
  },
  'Social Impact' => {
    description: <<-EOF.strip_heredoc.squish
    Many companies are beginning to understand that the impact they have on the world around them isn't just measured in dollars
    and cents, but also the lasting effects they have on the people and communities around them. Learn about how these
    companies are both thinking and acting differently, and how you can start to build social good into your company as well.
    EOF
  },
  'Business Basics' => {
    description: <<-EOF.strip_heredoc.squish
    Having the fundamental skills required to run a successful company are key to getting your startup off the ground. From
    accounting and finance to operations to marketing to accessing capital, come learn the ins and outs of running your company
    from the people in the community who have done it most sucessfully.
    EOF
  }
}.each do |cluster_name, attrs|
  c = Cluster.where(name: cluster_name).first_or_initialize

  # Skip if the record has been updated since it was populated
  next if c.updated_at && c.updated_at > c.created_at

  c.assign_attributes(attrs)
  c.save!
end

HomepageCta.reset_column_information
[
  {
    title: 'Call for Submissions',
    subtitle: 'Session submissions are open through {{ submission_close_date | date: "%B %e" }}',

    body: <<-EOF.strip_heredoc.squish,
      Denver Startup Week is powered by the community.
      Submit a topic for consideration for {{ current_date | date: "%Y" }}.
    EOF
    link_text: 'Submit a Topic',
    link_href: '/panel-picker/mine',
    relevant_to_cycle: 'cfp',
    priority: 100
  },
  {
    title: 'Voting is Open',
    subtitle: 'Cast your vote by {{ voting_close_date | date: "%B %e" }}',
    body: <<-EOF.strip_heredoc.squish,
      The sessions are in, now we need you to help us finalize the best for this year's event.
      Don't delay, cast your vote and spread the word.
    EOF
    link_text: 'Vote Now',
    link_href: '/panel-picker',
    relevant_to_cycle: 'voting',
    priority: 100
  },
  {
    title: 'Read our blog',
    subtitle: 'Stay up to date with DSW',
    body: 'Our new blog features the latest updates on DSW and the Denver entrepreneurial community.',
    link_text: 'Visit the blog',
    link_href: 'https://medium.com/denver-startup-week',
    priority: 0
  },
  {
    title: 'Registration is Open',
    subtitle: 'Register & build your personalized {{ current_date | date: "%Y" }} schedule',
    body: <<-EOF.strip_heredoc.squish,
      This year is going to be epic. We are excited to bring you the best of the best,
      and we couldn't have done this without you. Don't delay.
    EOF
    link_text: 'Check it out',
    link_href: '/schedule',
    relevant_to_cycle: 'registration',
    priority: 100
  },
  {
    title: 'Chase Basecamp',
    subtitle: 'Immerse yourself in the heart of it all',
    body: <<-EOF.strip_heredoc.squish,
      Whether you want to find inspiration,
      hone your business idea, or just refuel,
      Basecamp powered by Chase is your home base!
    EOF
    link_text: 'Learn More',
    link_href: '/basecamp',
    relevant_to_cycle: 'week',
    priority: 10
  },
  {
    title: 'Get Involved',
    subtitle: 'Be a part of something epic',
    body: 'We are actively looking for sponsors and volunteers! Contact us now to learn more.',
    link_text: 'Contact',
    link_href: '/contact',
    priority: 10
  }
].each do |attrs|
  c = HomepageCta.where(title: attrs[:title]).first_or_initialize

  # Skip if the record has been updated since it was populated
  next if c.updated_at && c.updated_at > c.created_at

  c.assign_attributes(attrs)
  c.save!
end

Sponsorship.reset_column_information
[
  {
    year: 2017,
    name: 'Aging 2.0 - Seniors Matter',
    description: <<-EOF.strip_heredoc.squish,
      Founded in 2012 by Stephen Johnston and Katy Fike, Aging2.0 supports innovators taking on the biggest challenges and opportunities in aging with an emphasis on enhancing access to innovation to improve the lives of the aging population across the globe.   Aging2.0 is international, interdisciplinary and intergenerational - focused on changing the conversation from local, clinical, siloed approaches to collaborative, lifestyle oriented, opportunity driven options.
    EOF
    logo: 'aging20.jpg',
    level: Sponsorship::TITLE_LEVEL,
    link_href: 'https://www.aging2.com/denver/',
    track_id: nil
  },
  {
    year: 2017,
    name: 'Chase for Business',
    description: <<-EOF.strip_heredoc.squish,
      Chase for Business is the bank for business. We offer a complete suite of industry leading financial products and resources, backed by expert advice. Learn more at chase.com/forbusiness.
    EOF
    logo: 'chase-biz.jpg',
    level: Sponsorship::TITLE_LEVEL,
    link_href: 'https://www.chase.com/business',
    track_id: nil
  },
  {
    year: 2017,
    name: 'Comcast',
    description: <<-EOF.strip_heredoc.squish,
      Comcast brings together the best in media and technology. We drive innovation to create the world’s best entertainment and online experiences.
    EOF
    logo: 'comcast.jpg',
    level: Sponsorship::TITLE_LEVEL,
    link_href: 'https://www.xfinity.com/',
    track_id: nil
  },
  {
    year: 2017,
    name: 'Downtown Denver Partnership',
    description: <<-EOF.strip_heredoc.squish,
      The Downtown Denver Partnership, Inc. partners with public, private and non-profit entities to implement high-impact strategies, outlined in the organization’s long-term strategy the 2007 Downtown Area Plan, to support its vision for an economically healthy, growing and vital Downtown Denver.
    EOF
    logo: 'ddp.jpg',
    level: Sponsorship::TITLE_LEVEL,
    link_href: 'http://www.downtowndenver.com/',
    track_id: nil
  },
  {
    year: 2017,
    name: 'WeWork',
    description: <<-EOF.strip_heredoc.squish,
      WeWork is a platform for creators, providing over 130,000 members around the world with space, community, and services through both physical and virtual offerings. WeWork currently has more than 160 physical locations in 52 cities and 16 countries around the world.
    EOF
    logo: 'wework.jpg',
    level: Sponsorship::TITLE_LEVEL,
    link_href: 'https://www.wework.com/',
    track_id: nil
  },
  {
    year: 2017,
    name: 'Herman Miller',
    description: <<-EOF.strip_heredoc.squish,
      Herman Miller helps companies create offices uniquely suited to the culture they’ve built and the ways their people work. The result is a workplace that makes people and customers proud to work with you, and has the flexibility to keep up as you grow. We use a potent mix of problem-solving products, a special pricing structure, and financing options to make this type of space a reality for companies of all sizes, including startups with limited budgets.
    EOF
    logo: 'herman-miller.png',
    level: Sponsorship::TRACK_LEVEL,
    link_href: 'https://www.hermanmiller.com/',
    track: Track.find_by!(name: 'Designer')
  },
  {
    year: 2017,
    name: 'Fanatics',
    description: <<-EOF.strip_heredoc.squish,
      As the global leader in licensed sports merchandise, Fanatics is changing the way fans purchase their favorite team apparel and jerseys across retail channels through an innovative, tech-infused approach to making and selling fan gear in today’s on-demand culture.
    EOF
    logo: 'fanatics.png',
    level: Sponsorship::TRACK_LEVEL,
    link_href: 'http://www.fanatics.com/',
    track: Track.find_by!(name: 'Developer')
  },
  {
    year: 2017,
    name: 'Healthgrades',
    description: <<-EOF.strip_heredoc.squish,
      Healthgrades is dedicated to empowering stronger and more meaningful connections between patients and their healthcare providers. We help 30 million consumers a month find and schedule appointments with their provider of choice. With our scheduling solutions and advanced analytics applications, we help more than 500 hospitals across the country to cultivate new patient relationships, improve patient access, and build customer loyalty.
    EOF
    logo: 'healthgrades.png',
    level: Sponsorship::TRACK_LEVEL,
    link_href: 'http://www.healthgrades.com/',
    track: Track.find_by!(name: 'Founder')
  },
  {
    year: 2017,
    name: 'AARP Colorado',
    description: <<-EOF.strip_heredoc.squish,
      The Innovation@50+™ initiative aims to spark entrepreneurial activity across public and private sectors. Anchored by the AARP social mission – to enhance the quality of life for all as we age – the initiative enlists the expertise of visionary thinkers, entrepreneurs, the investment community, industry and not-for-profits to spur innovation to meet the needs and wants of people over 50.
    EOF
    logo: 'aarp.png',
    level: Sponsorship::TRACK_LEVEL,
    link_href: 'http://states.aarp.org/region/colorado/',
    track: Track.find_by!(name: 'Growth')
  },
  {
    year: 2017,
    name: 'Colorado Lending Source',
    description: <<-EOF.strip_heredoc.squish,
      Colorado Lending Source helps turn dreamers into doers. By partnering with local lenders, government agencies and resource partners, we make access to capital more attainable for entrepreneurs. Through our 26 year history we’ve helped 3,533 small businesses start, grow and expand resulting in the creation of 25,845 jobs and more than $4 billion lent.
    EOF
    logo: 'colorado-lending-source.png',
    level: Sponsorship::TRACK_LEVEL,
    link_href: 'http://www.coloradolendingsource.org/',
    track: Track.find_by!(name: 'Maker')
  },
  {
    year: 2017,
    name: 'Pendo',
    description: <<-EOF.strip_heredoc.squish,
      Pendo helps companies create products that customers love. With powerful analytics, in-application user feedback, and contextual guidance designed to help companies measure and elevate the product experience in their applications, Pendo is on a mission to improve society’s experiences with software. Start a free trial at http://go.pendo.io/denverstartup.
    EOF
    logo: 'pendo.png',
    level: Sponsorship::TRACK_LEVEL,
    link_href: 'https://www.pendo.io/',
    track: Track.find_by!(name: 'Product')
  },
].each do |attrs|
  s = Sponsorship.where(name: attrs[:name], year: attrs[:year]).first_or_initialize

  # Skip if the record has been updated since it was populated
  next if s.updated_at && s.updated_at > s.created_at

  s.assign_attributes(attrs)
  s.save!
end
