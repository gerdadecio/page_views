class StreemEs
  def search(index, body)
    client.search index: index,  body: body
  end

  private

  def client
    @client ||= Elasticsearch::Client.new \
      url: ENV['ELASTICSEARCH_URL'],
      user: ENV['ELASTICSEARCH_USERNAME'],
      password: ENV['ELASTICSEARCH_PASSWORD']
  end
end