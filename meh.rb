require 'rest-client'

# Key: 2fae996bc7426244ea23602526c69681
# Secret: 7b31c1bcc276e8ea

res = RestClient.get 'http://example.com'

p res
