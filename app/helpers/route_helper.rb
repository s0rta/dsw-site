module RouteHelper

  def program_routes
    [program_route, tracks_route, clusters_route, basecamp_route, headline_events_route]
  end

  def program_route
    {
      path: "program",
      label: "overview"
    }
  end

  def tracks_route
    {
      path: "program/tracks",
      label: "tracks"
    }
  end

  def tracks_route_designer
    {
      path: "program/tracks/designer",
      label: "designer track"
    }
  end

  def tracks_route_track_details
    {
      path: "program/track_details",
      label: "track details"
    }
  end

  def clusters_route
    {
      path: "program/clusters",
      label: "clusters"
    }
  end

  def basecamp_route
    {
      path: "basecamp",
      label: "basecamp"
    }
  end

  def headline_events_route
    {
      path: "program/headline-events",
      label: "headline events"
    }
  end

  def active_link_class(route)
    current_path?(route) ? "is-active" : ""
  end

  private

  def request_path
    request.path[1...request.path.length]
  end

  def current_path?(route)
    request_path == route[:path]
  end

end
