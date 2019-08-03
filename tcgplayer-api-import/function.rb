def function(response:, router:, database:)
  response.status = :ok
end

def generate_token
  uri = URI.parse("https://api.tcgplayer.com/token")
  request = Net::HTTP::Post.new(uri)
  request.set_form_data(
    "client_id" => ENV["TCGPLAYER_CLIENT_ID"],
    "client_secret" => ENV["TCGPLAYER_CLIENT_SECRET"],
    "grant_type" => "client_credentials",
  )

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end
  binding.pry
end