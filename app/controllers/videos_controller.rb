class VideosController < ApplicationController
  include ApplicationHelper

  def show
    return redirect_to :root if param_blank?(params[:q])

    @video = Video.find_by(video_id: params[:video_id])
    search_result = LiveChatMessage.search(@video.video_id, params[:q], page: params[:p].to_i)
    @messages = search_result[:messages]

    @paginatable_array = Kaminari.paginate_array([], total_count: search_result[:total_count])
                                 .page(params[:p])
                                 .per(LiveChatMessage::PER_SIZE)
  end
end
