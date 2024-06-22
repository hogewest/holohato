namespace :holohato do
  namespace :index do
    desc 'Create index'
    task create: :environment do |task|
      Task.run(task) do
        client = OpenSearch::OpenSearchClient.new
        mappings = JSON.parse(File.read(__FILE__).split('__END__').last)
        mappings["settings"]["index"]["max_result_window"] = LiveChatMessage::MAX_RESULT_WINDOW
        client.create_index(name: LiveChatMessage::INDEX_NAME, body: mappings)
      end
    end
  end
end

__END__
{
  "settings": {
    "index": {
      "max_result_window": 1000000
    }
  },
  "mappings": {
    "properties": {
      "join": {
        "type": "join",
        "relations": {
          "video": "message" 
        }
      },
      "video_id": {
        "type": "keyword"
      },
      "video_published_at": {
        "type": "date"
      },
      "message": {
        "type": "keyword"
      },
      "normalized_message": {
        "type": "keyword"
      },
      "timestamp_text": {
        "type": "keyword"
      },
      "timestamp_usec": {
        "type": "long"
      },
      "video_offset_time_msec": {
        "type": "long"
      }
    }
  }
}
