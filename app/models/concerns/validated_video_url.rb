module ValidatedVideoUrl
  extend ActiveSupport::Concern

  YOUTUBE_REGEX = %r{\A(?:http://|https://)?youtu.be/(\S+)\z}

  included do
    validates :video_url,
      format: {with: YOUTUBE_REGEX, allow_blank: true}
  end

  def embed_video_url(extra_params = {modestbranding: 1, showinfo: 0})
    "https://www.youtube.com/embed/#{YOUTUBE_REGEX.match(video_url)[1]}?#{extra_params.to_query}"
  end
end
