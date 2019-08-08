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
  #doesn't work when we're on the same &page= as in the url_format line

  url_format = "https://www.cardmarket.com"
  url_format += raw.css("div#pagination").css("a.dropdown-item")[1].attributes["href"].text

  raw.css("div#pagination").css("a.dropdown-item").map do |page|
    url_format.gsub(/site=[0-9]/, "site=#{page.children.text}")
  end
end

def scrape_set(set_url)
  every_page(set_url).each do |page|
    LOGGER.info "Scraping set data from #{page}"
    raw = Nokogiri::HTML(Net::HTTP.get(URI(page)))
    raw.css('div[id^="productRow"]').each do |card|
      card_data = Hash.new

      card_data["card_url"] = card.css("a")[1]["href"]
      card_data["card_name"] = card.css("div.col-10.col-md-8.px-2.flex-column.align-items-start.justify-content-center").text
      card_data["card_set_number"] = card.css("div.col-md-2.d-none.d-lg-flex.has-content-centered").text
      # rarity = card.css("div.col-sm-2.d-none.d-sm-flex.has-content-centered > span > span")
      card_data["available_inventory"] = card.css("div.col-availability.px-2 > span").text
      card_data["lowest_eur"] = card.css("div.col-price.pr-sm-2").text
      card_data["available_inventory_foil"] = card.css("div.col-availability.d-none.d-lg-flex").text
      card_data["lowest_eur_foil"] = card.css("div.col-price.d-none.d-lg-flex.pr-lg-2").text
    end
  end
end

def scrape_card_page(url)
  LOGGER.info "Scraping card data from #{url}"
  raw = Nokogiri::HTML(Net::HTTP.get(URI(url)))
  binding.pry
  card_data = Hash.new

  # basic info
  card_data["available_inventory"]
  card_data["lowest_eur"]
  card_data["price_trend"]
  card_data["thirty_day_average_price"]
  card_data["seven_day_average_price"]

  # seller inventories
end