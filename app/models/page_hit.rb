class PageHit

  def self.search(urls = [], options = {})
    @errors = ActiveModel::Errors.new(self)

    page_hits = Hash.new {|h,k| h[k] = Hash.new(0) }

    before = options[:before]
    after = options[:after]

    @errors.add(:url, 'should be an array of urls') if urls.class != Array
    @errors.add(:before, 'is required') if before.blank?
    @errors.add(:after, 'is required') if after.blank?

    validate_time(:before, options[:before])
    validate_time(:after, options[:after])

    return @errors if @errors.present?

    urls.each do |url|
      page_hits[url] = StreemEs.new.search(
        'events',
        { page_url: url }.merge(options)
      )
    end
    page_hits
  end


  private

  def self.validate_time(k,time)
    return unless time
    Time.at(time.to_f / 1000)
  rescue
    @errors.add(k, 'Invalid datetime format!')
  end

end