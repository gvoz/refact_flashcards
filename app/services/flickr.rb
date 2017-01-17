require 'flickraw'

class Flickr
  def self.photo(tag)
    FlickRaw.api_key = ENV["API_KEY"]
    FlickRaw.shared_secret = ENV["SHARED_SECRET"]

    photos = flickr.photos.search(tags: tag, per_page: 10)
    photos.collect do |photo|
      URI.join "https://farm#{photo.farm}.staticflickr.com/", "#{photo.server}/", "#{photo.id}_#{photo.secret}.jpg"
    end
  end
end
