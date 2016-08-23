# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

{
  'Founder' => {
    icon: 'person',
    color: 'orange',
    description: "Whether you're just dreaming about starting a business, on your first, or a seasoned entrepreneur, the founder track will provide you with the skills and knowledge you need to found a company. Initial product development, go-to-market strategies, finding funding, and building a team are just some of the topics that are covered. Start down the path of creating your startup!"
  },
  'Growth' => {
    icon: 'chart',
    color: 'blue',
    description: "No matter how good it is, no product sells itself. A team that markets, sells, and supports the product well is a huge advantage for any startup. Every aspect of digital marketing, inbound and outbound sales, and customer experience is going to be covered at Denver Startup Week. Growing a startup depends on these skills, don't miss your chance to improve them!"
  },
  'Designer' => {
    icon: 'eyeball',
    color: 'green',
    description: "Seeing things others do not see is an art and our design track is packed with creative outlets to expand your thinking and ability to design.  From fashion to architecture to breakout digital design and artwork – the design track is focused on the critical elements of design. Learn new skills, hear from those responsible for some of the best projects in Colorado, and let your creative juices flow. Enjoy connecting with fellow design leaders and leave the week with fresh inspiration!",
  },
  'Product' => {
    icon: 'phone',
    color: 'purple',
    description: "Product management, development, and marketing, all different sides of the same coin that somehow bridges the gap between building the product and delivering it to the market. Product skills are in huge demand but there aren't very many places where you can go to acquire them. Come improve your product game at Denver Startup Week!"
  },
  'Developer' => {
    icon: 'terminal',
    color: 'gold',
    description: 'Frontend, backend, full stack, big data, APIs, architecture, methodologies, junior, senior, we have it all. Learn new technologies, refine your skills, or just check out something completely different. Walk away a better engineer than you were before!'
  },
  'Maker' => {
    icon: 'wrench',
    color: 'teal',
    description: "From craft skis to craft beer, robots to 3D printing – the experience of 'making' physical products is totally unique. Through the lens of physical goods across multiple industries, hear the stories behind breakout brands, learn about new technologies in manufacturing, and dig into the micro-production concepts needed to get started.  Connect with the best craftsmen and makers in Colorado and see how they create their work – all in one week!"
  },
  'Headline Events' => {
    icon: nil
  },
  'Basecamp' => {
    icon: nil
  },
  'Social Events' => {
    icon: nil
  }
}.each do |track_name, attrs|
  t = Track.where(name: track_name).first_or_initialize
  t.assign_attributes(attrs)
  t.save!
end

{
  'IoT' => {
    description: 'From smart devices to integrated homes to intelligent vehicles, the Internet of Things is rapidly transforming the way that we interact with the world around us. Check out the latest technologies and trends in the IoT realm, and take a look behind the scenes at what it takes to concept, design and build a connected product.'
  },
  'Diversity' => {
    description: 'Building an inclusive organization and culture is a critical part of any early-stage company, particularly in a world of increasingly global and diverse customer bases. Explore the what, how and why of building a diverse team, and hear firsthand the experiences of those on the front lines enabling diversity in the startup realm.'
  },
  'Cannatech' => {
    description: 'Colorado is at the forefront not only of entrepreneurship and technology, but also in the emerging cannabis industry. Beyond just the leaf, explore the intersection of technology and cannabis, how these two seemingly different fields interoperate, and the challenges of building a company at the intersection of emerging markets and regulatory frameworks.',
  },
  'Healthtech' => {
    description: 'The collision of the worlds of healthcare and technology is affording many unique opportunities to have a lasting impact on a large number of people. Explore the applications of technology within the healthcare space from the perspectives of both technologists and healthcare professionals, and see the ways in which technological innovations are making a real difference.'
  }
}.each do |cluster_name, attrs|
  c = Cluster.where(name: cluster_name).first_or_initialize
  c.assign_attributes(attrs)
  c.save!
end
