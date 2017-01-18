require 'rails_helper'

describe Flickr do
  describe 'find photo' do
    let(:response) do
      { "photos": { "page": 1, "pages": 100, "perpage": 100, "total": "1000",
      "photo": [
        { "id": "15340023391", "owner": "126717374@N05", "secret": "993189bdc8", "server": "2944", "farm": 1, "title": "Flickr photo 1", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
        { "id": "15340123391", "owner": "126717374@N01", "secret": "993289bdc8", "server": "294", "farm": 2, "title": "Flickr photo 2", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
        { "id": "15340223391", "owner": "126717374@N02", "secret": "993389bdc8", "server": "244", "farm": 1, "title": "Flickr photo 3", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
        { "id": "15340323391", "owner": "126717374@N03", "secret": "994189bdc8", "server": "244", "farm": 3, "title": "Flickr photo 4", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
        { "id": "15340423391", "owner": "126717374@N03", "secret": "993189bdc8", "server": "944", "farm": 1, "title": "Flickr photo 5", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
        { "id": "15340523391", "owner": "126717174@N05", "secret": "993189bdc8", "server": "244", "farm": 4, "title": "Flickr photo 6", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
        { "id": "15340623391", "owner": "126717474@N05", "secret": "943189bdc8", "server": "2944", "farm": 3, "title": "Flickr photo 7", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
        { "id": "15340723391", "owner": "126757374@N05", "secret": "993189adc8", "server": "244", "farm": 2, "title": "Flickr photo 8", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
        { "id": "15340723391", "owner": "126777374@N05", "secret": "993189bdc8", "server": "294", "farm": 1, "title": "Flickr photo 9", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
        { "id": "15340823391", "owner": "124717374@N05", "secret": "993189bcc8", "server": "2944", "farm": 1, "title": "Flickr photo 10", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
      ] } }.to_json
    end

    before do
      stub_request(:post, "https://api.flickr.com/services/rest/").to_return(status: 200, body: response)
    end

    it 'return image url' do
      request = Flickr.photo('photo')
      expect(request).to be_instance_of(Array)
      expect(request.length).to eq 10
    end
  end
end
