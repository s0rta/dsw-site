module RouteHelper

  def admin_root_path
    {
      path: "/admin",
      label: "Admin"
    }
  end

  def main_menu
    menu = [home_route, main_program_route, main_about_route, sponsors_route, main_get_involved_route, articles_route]

    menu.push schedule_route if registration_open? || AnnualSchedule.post_week?
    menu.push register_route if registration_open? && !registered?
    menu.push voting_route if AnnualSchedule.voting_open?

    menu
  end

  def program_routes
    routes = [program_route, tracks_route]
    routes.push clusters_route unless Cluster.active.empty?
    routes.push basecamp_route
    routes
  end

  def about_routes
    [about_route, team_route, faq_route, assets_route]
  end

  def social_media_routes
    [
      { icon: "fa-twitter", label: "twitter", link: "https://twitter.com/denstartupweek" },
      { icon: "fa-facebook-f", label: "facebook", link: "https://www.facebook.com/DenverStartupWeek" },
      { icon: "fa-linkedin-in", label: "linkedin", link: "https://www.linkedin.com/company/denver-startup-week/" },
      { icon: "fa-youtube", label: "youtube", link: "https://www.youtube.com/c/denverstartupweek" }
    ]
  end

  def footer_nav_routes
    routes = [faq_route, assets_route, code_of_conduct_route, contact_us_route]
    routes.unshift admin_root_path if signed_in? && current_user.is_admin?
    routes
  end

  def contact_us_route
    {
      path: new_general_inquiry_path,
      label: "Contact Us"
    }
  end

  def code_of_conduct_route
    {
      path: "/code-of-conduct",
      label: "Code of Conduct"
    }
  end

  def home_route
    {
      path: "/",
      label: "home"
    }
  end

  def main_about_route
    {
      path: "/about",
      label: "about",
      nested_routes: about_routes
    }
  end

  def about_route
    {
      path: "/about",
      label: "overview"
    }
  end

  def team_route
    {
      path: "/about/team",
      label: "team"
    }
  end

  def faq_route
    {
      path: "/about/faq",
      label: "faq"
    }
  end

  def assets_route
    {
      path: "/about/assets",
      label: "assets"
    }
  end

  def sponsor_route
    {
      path: "/get-involved/sponsor",
      label: "sponsor"
    }
  end

  def sponsors_route
    {
      path: "/sponsors",
      label: "sponsors"
    }
  end

  def main_get_involved_route
    {
      path: "/get-involved",
      label: "get involved",
    }
  end

  def get_involved_route
    {
      path: "/get-involved",
      label: "overview"
    }
  end

  def volunteer_route
    {
      path: "https://www.cervistech.com/acts/console.php?console_id=0282&console_type=event&ht=1",
      label: "volunteer"
    }
  end

  def present_route
    {
      path: new_submission_path,
      label: "present"
    }
  end

  def content_route
    {
      path: "/get-involved/content",
      label: "content"
    }
  end

  def schedule_route
    {
      path: schedules_path,
      label: "schedule"
    }
  end

  def submissions_route
    {
      path: new_submission_path,
      label: "Submit a Talk"
    }
  end

  def voting_route
    {
      path: submissions_path,
      label: "Vote"
    }
  end

  def register_route
    {
      path: new_registration_path,
      label: "Register To Attend"
    }
  end

  def main_program_route
    {
      path: "/program",
      label: "program",
      nested_routes: program_routes
    }
  end

  def articles_route
    {
      path: articles_path,
      label: "Articles"
    }
  end

  def program_route
    {
      path: "/program",
      label: "overview"
    }
  end

  def tracks_route
    {
      path: "/program/tracks",
      label: "tracks"
    }
  end

  def track_detail_route(name)
    {
       path: "/program/tracks/#{name}",
       label: name
    }
  end

  def clusters_route
    {
      path: "/program/clusters",
      label: "clusters"
    }
  end

  def basecamp_route
    {
      path: "/program/tracks/Basecamp",
      label: "basecamp"
    }
  end

  def active_link_class(route)
    current_path?(route) ? "is-active" : ""
  end

  def menu_starting_nav
    starting_nav = ""
    main_menu.each do |item|
      next unless item[:nested_routes].present?
      if item[:nested_routes].any? { |r| r[:path] == request.path }
        starting_nav = item[:label].parameterize
      end
    end
    starting_nav
  end

  def came_from_registration?
    session[:after_auth_url] == new_registration_path ||
      session[:after_auth_url] == register_path
  end

  private

  def current_path?(route)
    request.path == route[:path]
  end

end
