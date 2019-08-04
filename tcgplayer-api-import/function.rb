def function(response:, router:, database:)
  response.status = :ok
  token = generate_token()

  response = sample_request("http://api.tcgplayer.com/v1.32.0/catalog/categories/1/groups", token)
  JSON.parse(response.read_body)
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
  JSON.parse(response.read_body)["access_token"]
end

def sample_request(request_url, bearer_token)
  uri = URI.parse(request_url)
  request = Net::HTTP::Get.new(uri)
  request["Authorization"] = "Bearer " + bearer_token

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end
end