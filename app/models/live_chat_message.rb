class LiveChatMessage
  INDEX_NAME = 'live-chat-message'
  MAX_RESULT_WINDOW = 1000000
  PER_SIZE = 30

  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :video_id, :string
  attribute :message, :string
  attribute :timestamp_text, :string
  attribute :timestamp_usec, :integer
  attribute :video_offset_time_msec, :integer

  def self.search(video_id, q, page: 1, per: LiveChatMessage::PER_SIZE)
    message_query = "*#{self.escape_wildcard_query(self.normalize_message(q))}*"
    search_body = {
      from: from(page, per),
      size: per,
      sort: {
        timestamp_usec: :asc
      },
      query: {
        bool: {
          must: [
            { term: { video_id: video_id } },
            { wildcard: { normalized_message: message_query } }
          ]
        }
      }
    }
    client = OpenSearch::OpenSearchClient.new
    hists = client.search(index: self::INDEX_NAME, body: search_body)["hits"]
    messages = hists["hits"].map do |item|
      message = item["_source"]
      LiveChatMessage.new(
        video_id: message["video_id"],
        message: message["message"],
        timestamp_text: message["timestamp_text"],
        timestamp_usec: message["timestamp_usec"],
        video_offset_time_msec: message["video_offset_time_msec"],
      )
    end

    {
      messages: messages,
      total_count: hists["total"]["value"]
    }
  end

  def self.search_video(q, page: 1, per: 10, least_count: 1)
    message_query = "*#{self.escape_wildcard_query(self.normalize_message(q))}*"
    search_body = {
      from: from(page, per),
      size: per,
      sort: {
        video_published_at: :desc,
        _id: :asc
      },
      query: {
        has_child: {
          type: :message,
          query: {
            bool: {
              must: [
                { wildcard: { normalized_message: message_query } }
              ]
            }
          },
          min_children: least_count < 1 ? 1 : least_count,
        }
      }
    }
    client = OpenSearch::OpenSearchClient.new
    hists = client.search(index: self::INDEX_NAME, body: search_body)["hits"]
    videos = hists["hits"]
    video_ids = videos.map {_1["_id"]}

    count_body = {
      size: 0,
      query: {
        bool: {
          must: [
            { terms: { video_id: video_ids } },
            { wildcard: { normalized_message: message_query } }
          ]
        }
      },
      aggs: {
        count: {
          terms: { field: :video_id }
        }
      }
    }
    buckets = client.search(index: self::INDEX_NAME, body: count_body)["aggregations"]["count"]["buckets"]
    count = buckets.map { [_1["key"], _1["doc_count"].to_i] }.to_h
    videos = video_ids.map do |video_id|
      {
        video_id: video_id,
        message_count: count[video_id]
      }
    end

    {
      videos: videos,
      total_count: hists["total"]["value"]
    }
  end

  def self.normalize_message(message)
    NKF.nkf('--hiragana -w', message.unicode_normalize(:nfkc))
  end

  def self.escape_wildcard_query(query)
    special_chars = /[\?\*]/
    query.gsub(special_chars) { |match| "\\#{match}" }
  end
  
  def self.from(page, per)
    page <= 1 ? 0 : (page - 1) * per
  end

  private_class_method :from
end
