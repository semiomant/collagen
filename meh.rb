require 'rest-client'

api_base = "https://api.flickr.com/services/rest/?format=json&method="


def get_key base
   target = base+"flickr.tags.getHotList&api_key="
   #open file for secret
   f = File.open("mysecret.txt", "r:UTF-8")
   key = f.readline.chomp
   f.close
   target += key
   #test-get
   res = RestClient.get target
   puts res
end

get_key api_base
#res = RestClient.get 'http://'
#p res
