module VideosHelper
  def youtube_video_url(vide_id, video_offset_time_msec)
    t = video_offset_time_msec / 1000 - 10
    t = 0 if t < 0
    "https://www.youtube.com/watch?v=#{vide_id}&t=#{t}s"
  end
end
