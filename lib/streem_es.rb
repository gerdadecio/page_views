class StreemEs
  def search(index, page_url: '', after: nil, before: nil , interval: nil)
    body = request_body.tap do |t|
      t[:query][:bool][:must] << build_page_url_match(page_url)
      t[:query][:bool][:must] << build_range(before, after) if before.present? && after.present?
    end.merge(build_aggregation(interval))

    client.search \
      index: index,
      body: body
  end

  private

  def build_aggregation(interval)
    return {} unless interval
    {
      aggs: {
        events_over_time: {
          date_histogram: {
            field: "derived_tstamp",
            interval: interval
          }
        }
      }
    }
  end

  def build_range(before, after)
    {
      range: {
        derived_tstamp: {
          gte: after,
          lte: before
        }
      }
    }
  end

  def build_page_url_match(url)
    {
      match: { page_url: url }
    }
  end

  def request_body
    {
      size: 0,
      query: {
        bool: {
          must: []
        }
      }
    }
  end

  def client
    @client ||= Elasticsearch::Client.new \
      url: ENV['ELASTICSEARCH_URL'],
      user: ENV['ELASTICSEARCH_USERNAME'],
      password: ENV['ELASTICSEARCH_PASSWORD']
  end
end
