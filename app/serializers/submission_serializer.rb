class SubmissionSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :description,
             :format,
             :track_name,
             :venue_name,
             :venue_address,
             :start_datetime,
             :end_datetime,
             :registrant_count,
             :link

  def title
    object.full_title
  end

  def track_name
    object.track.name
  end

  def venue_name
    object.venue.name if object.venue
  end

  def venue_address
    object.venue.combined_address if object.venue
  end

  def registrant_count
    object.session_registrations.count
  end

  def link
    schedule_url(object)
  end
end
