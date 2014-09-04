Cmsimple.configure do |config|

  # the parent controller for all the page CRUD activities
  config.parent_controller = 'AuthenticatedController'

  # the parent controller for the page rendering
  config.parent_front_controller = 'ApplicationController'

  # the path the templates are loaded from
  # config.template_path = 'cmsimple/templates'

  # the path carrierwave will use to store image assets
  # config.asset_path = 'uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}'

  # stylesheets to be included in the editor layout page
  # config.editor_stylesheets << 'cmsimple_overrides'

  # javascripts to be included in the editor layout page
  # config.editor_javascripts << 'cmsimple_overrides'

  # set this to change layouts or pass other params into rendering a template
  config.template_render_options = { }

end
