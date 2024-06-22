module Indexer
  class LiveChatNotFoundError < StandardError; end

  def self.indexing_live_chat_messages(video)
    youtube = Youtube::YoutubeApiClient.new
    Dir.mktmpdir do |dir|
      video_id = video.video_id

      Rails.logger.info("Download live chat messages. video_id:#{video_id} dir:#{dir}")
      output, error, success, donwload_file = youtube.download_live_chat_message(video_id:, path: dir)
      unless success
        if error.include?('members-only')
          Rails.logger.info("video_id:#{video_id} is members-only content")
          return :skip
        end
        raise StandardError.new("Download live chat messages failed. video_id:#{video_id}, output:#{output} error:#{error}")
      end
      unless File.exist?(donwload_file)
        if youtube.live_chat_replay_off?(video_id:)
          return :skip
        else
          raise LiveChatNotFoundError.new("Live chat data file did not exist. video_id:#{video_id}")
        end
      end
      Rails.logger.info("Download completed. video_id:#{video_id}")

      Rails.logger.info("create video document index. video_id:#{video_id}")
      client = OpenSearch::OpenSearchClient.new
      client.index(
        index: LiveChatMessage::INDEX_NAME,
        id: video_id,
        body: {
          video_published_at: video.published_at,
          join: "video",
        }
      )
      Rails.logger.info("completed create video document index. video_id:#{video_id}")

      actions = []
      File.foreach(donwload_file) do |line|
        next if line.empty?
        data = self.parse_live_chat(JSON.parse(line))
        next if data.empty?

        actions.push({ index: { _index: LiveChatMessage::INDEX_NAME, _id: data[:client_id]} })
        actions.push({
          video_id:,
          message: data[:message],
          normalized_message: LiveChatMessage.normalize_message(data[:message]),
          timestamp_text: data[:timestamp_text],
          timestamp_usec: data[:timestamp_usec],
          video_offset_time_msec: data[:video_offset_time_msec],
          join: {
            name: "message",
            parent: video_id,
          }
        })
      end

      Rails.logger.info("create message document index. video_id:#{video_id}")
      client.bulk(actions:, routing: video_id)
      Rails.logger.info("completed create message document index. video_id:#{video_id}")
    end
    :done
  end

  def self.parse_live_chat(json)
    replay_chat_item_action = json.dig('replayChatItemAction')
    return [] if replay_chat_item_action.nil?

    actions = replay_chat_item_action.dig('actions')
    return [] if actions.nil? || actions.empty?

    action = actions.first
    renderer = action.dig('addChatItemAction', 'item', 'liveChatTextMessageRenderer')
    return {} if renderer.nil?

    runs = renderer.dig('message', 'runs')
    return {} if runs.nil? || runs.empty?

    message = runs.map { |run| run.dig('text')&.strip }.compact.join
    return {} if message.empty?

    {
      message: message,
      timestamp_text: renderer['timestampText']['simpleText'],
      timestamp_usec: renderer['timestampUsec'],
      video_offset_time_msec: replay_chat_item_action['videoOffsetTimeMsec'],
      client_id: action.dig('addChatItemAction', 'clientId')
    }
  end
end
