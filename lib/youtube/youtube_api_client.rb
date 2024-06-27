module Youtube
  class YoutubeApiClient
    def initialize()
      @service = Google::Apis::YoutubeV3::YouTubeService.new
      @service.key = ENV['YOUTUBE_API_KEY']
    end

    def search_videos(channel_id:, published_after:)
      opt = {
        channel_id:   channel_id,
        order:        'date',
        max_results:  10,
        published_after: published_after,
      }
      @service.list_searches('snippet', **opt)
    end

    def download_live_chat_message(video_id:, path:)
      command = "yt-dlp --no-color --no-progress --extractor-args youtube:player_client=ios,web --write-sub --no-download --retries 3 -P \"#{path}\" -o \"#{video_id}\" -- #{video_id}"
      o, e, s = Open3.capture3(command)
      [o, e, s.success?, File.join(path, "#{video_id}.live_chat.json")]
    end

    def shorts_video?(video_id:)
      url = URI.parse("https://www.youtube.com/shorts/#{video_id}")
      response = Net::HTTP.get_response(url)
      !response.is_a?(Net::HTTPRedirection)
    end

    def live_chat_replay_off?(video_id:)
      url = URI.parse("https://www.youtube.com/watch?v=#{video_id}")
      Net::HTTP.get(url, {"Accept-Language" => "en"}).include?("Live chat replay is not available for this video")
    end
  end
end
