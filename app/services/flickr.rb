class Flickr
  attr_reader :tag, :per_page, :flickr

  def initialize(tag, per_page = 9)
    @tag = tag
    @per_page = per_page
    @flickr = FlickRaw::Flickr.new(
      api_key: ENV["API_KEY"],
      shared_secret: ENV["SHARED_SECRET"]
    )
  end

  def call
    photos.collect do |photo|
      URI.join "https://farm#{photo.farm}.staticflickr.com/", "#{photo.server}/", "#{photo.id}_#{photo.secret}.jpg"
    end
  end

  def photos
    Rails.cache.fetch("#{tag}/#{per_page}", expires_in: 6.hours) do
      flickr.photos.search(tags: tag, per_page: per_page)
    end
  end
end
