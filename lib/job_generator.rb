module JobGenerator
  def self.generate(published_after:)
    youtube = Youtube::YoutubeApiClient.new
    published_after_iso8601 = published_after.to_time.iso8601

    channels = Channel.order(:id).all
    channels.each do |channel|
      videos = youtube.search_videos(channel_id: channel.channel_id, published_after: published_after_iso8601)
      videos.items.each do |item|
        next if ["live", "upcoming"].include?(item.snippet.live_broadcast_content)
        next if item.id.video_id.nil?
        next if item.snippet.channel_id != channel.channel_id

        video_id = item.id.video_id
        video = channel.videos.find_or_initialize_by(video_id:)
        video.title = CGI.unescape_html(item.snippet.title)
        video.published_at = item.snippet.published_at
        video.thumbnails = item.snippet.thumbnails
        video.save!

        next if Job.exists?(video_id:)

        is_shorts = youtube.shorts_video?(video_id:)
        Job.create(
          video_id:,
          state: is_shorts ? :skip : :waiting,
          retry_count: 0,
        )
      end
    end
  end
end
