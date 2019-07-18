def function(response:, router:, database:)
  response.status = :ok
end

require 'uri'
require 'net/http'

url = URI("http://api.tcgplayer.com/v1.27.0/app/authorize/" + ENV["TCGPLAYER_ACCESS_TOKEN"])

http = Net::HTTP.new(url.host, url.port)

request = Net::HTTP::Post.new(url)

response = http.request(request)
puts response.read_body