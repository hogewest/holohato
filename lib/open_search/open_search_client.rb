module OpenSearch
  class OpenSearchClient
    def initialize()
      open_search_host = URI(ENV['OPEN_SEARCH_HOST'])
      open_search_host.userinfo = "#{ENV['OPEN_SEARCH_USER']}:#{ENV['OPEN_SEARCH_PASSWORD']}"
      ssl_verify = ENV['OPEN_SEARCH_SSL_VERIFY'] ? ENV['OPEN_SEARCH_SSL_VERIFY'] === 'true' : true
      @client = OpenSearch::Client.new(
        host: open_search_host.to_s,
        retry_on_failure: 3,
        log: false,
        transport_options: { ssl: { verify: ssl_verify } },
      )
    end

    def create_index(name:, body:)
      @client.indices.create(index: name, body: body)
    end

    def index(index:, id:, body:, refresh: true)
      @client.index(
        index:,
        body:,
        id:,
        refresh:
      )
    end

    def bulk(actions:, refresh: true, routing: nil, batch_size: 10000)
      actions.each_slice(batch_size) do
        @client.bulk(body: _1, routing:, refresh:)
      end
    end

    def search(index:, body:)
      @client.search(body:, index:)
    end
  end
end
