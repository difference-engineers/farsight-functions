def function(response:, router:, database:)
  response.status = :ok
end

def set_ids
  LOGGER.info("Getting cardmarket's set ids")

  url = "https://www.cardmarket.com/en/Magic/Products/Singles"

  discard = ["All"]
  raw = Nokogiri::HTML(Net::HTTP.get(URI(url)))
  raw.css('select[name=idExpansion]').css('option').map do |set|
    (Integer(set["value"], 10)) unless discard.include?(set.children.text)
  end.compact
end

def set_slugs
end

def every_page(set_url)
  raw = Nokogiri::HTML(Net::HTTP.get(URI(set_url)))
  return_urls = []

  #still need handling for pages with no pagination, and for urls without site=x

  url_format = "https://www.cardmarket.com"
  url_format += raw.css("div#pagination").css("a.dropdown-item")[0].attributes["href"].text

  raw.css("div#pagination").css("a.dropdown-item").map do |page|
    url_format.gsub(/site=[0-9]/, "site=#{page.children.text}")
  end
end
