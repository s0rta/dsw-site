Navigasmic.setup do |config|

  config.semantic_navigation :primary do |n|
    n.item '', '/', class: 'home-icon'
    n.item 'Information', '/information'
    n.item 'Event Descriptions', '/event-descriptions'
    n.item 'Event Schedule', '/event-schedule'
    n.item 'Sponsors', '/sponsors'
  end

  config.semantic_navigation :footer do |n|
    n.item 'Information', '/information'
    n.item 'Event Descriptions', '/event-descriptions'
    n.item 'Event Schedule', '/event-schedule'
    n.item 'Sponsors', '/sponsors'
  end

  # Naming Builder Configurations:
  #
  # If you want to define a named configuration for a builder, just provide a hash with the name and the builder to
  # configure.  The named configurations can then be used during rendering by specifying a `:config => :bootstrap`
  # option.
  #
  # A Twitter Bootstrap configuration:
  #
  # Example usage:
  #
  # <%= semantic_navigation :primary, config: :bootstrap, class: 'nav-pills' %>
  #
  # Or to create a full navigation bar using twitter bootstrap you could use the following in your view:
  #
  # <div class="navbar">
  #   <div class="navbar-inner">
  #     <a class="brand" href="/">Title</a>
  #     <%= semantic_navigation :primary, config: :bootstrap %>
  #   </div>
  # </div>
  config.builder bootstrap: Navigasmic::Builder::ListBuilder do |builder|

    # Set the nav and nav-pills css (you can also use 'nav nav-tabs') -- or remove them if you're using this inside a
    # navbar.
    builder.wrapper_class = 'nav nav-pills'

    # Set the classed for items that have nested items, and that are nested items.
    builder.has_nested_class = 'dropdown'
    builder.is_nested_class = 'dropdown-menu'

    # For dropdowns to work you'll need to include the bootstrap dropdown js
    # For groups, we adjust the markup so they'll be clickable and be picked up by the javascript.
    builder.label_generator = proc do |label, options, has_link, has_nested|
      if !has_nested || has_link
        "<span>#{label}</span>"
      else
        link_to("#{label}<b class='caret'></b>".html_safe, '#', class: 'dropdown-toggle', data: {toggle: 'dropdown'})
      end
    end

    # For items, we adjust the links so they're '#', and do the same as for groups.  This allows us to use more complex
    # highlighting rules for dropdowns.
    builder.link_generator = proc do |label, link, link_options, has_nested|
      if has_nested
        link = '#'
        label << "<b class='caret'></b>"
        options.merge!(class: 'dropdown-toggle', data: {toggle: 'dropdown'})
      end
      link_to(label, link, link_options)
    end

  end

end
