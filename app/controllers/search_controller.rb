class SearchController < ApplicationController
  include ApplicationHelper

  def search
    return redirect_to :root if param_blank?(params[:q])

    @q = params[:q]
    video_search_result = LiveChatMessage.search_video(strip_space(@q), page: params[:p].to_i)
    video_ids = video_search_result[:videos].map {_1[:video_id]}
    message_count = video_search_result[:videos].map {[_1[:video_id], _1[:message_count]]}.to_h
    videos = Video.where(video_id: video_ids).in_order_of(:video_id, video_ids).includes(:channel)
    @search_results = videos.map do |video|
      {
        video: video,
        count: message_count[video.video_id]
      }
    end

    @paginatable_array = Kaminari.paginate_array([], total_count: video_search_result[:total_count]).page(params[:p])
  end
end
