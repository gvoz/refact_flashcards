require 'rails_helper'

describe 'Use Flickr Api' do
  describe 'find photo' do
    it 'get photos' do
      VCR.use_cassette('flickr_photos') do
        photos = Flickr.new('photo', 10).call

        expect(photos).to be_instance_of(Array)
        expect(photos.length).to eq 10
      end
    end
  end
end
