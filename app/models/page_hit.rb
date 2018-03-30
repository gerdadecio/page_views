class PageHit
  def self.search urls = []
    raise ArgumentError.new('Should be and array of urls') if urls.class != Array

    page_hits = []
    urls.each do |url|
      page_hits << StreemEs.new.search(
        'events',
        {
          query: { match: { page_url: url } }
        }
      )
    end
    page_hits
  end
end