require 'rest-client'

$api_base = "https://api.flickr.com/services/rest/?method="


def get_key
   p $api_base+"flickr.tags.getHotList"
   #open file for secret
end

get_key
#res = RestClient.get 'http://'
#p res
