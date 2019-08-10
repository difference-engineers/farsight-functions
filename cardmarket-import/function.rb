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
  LOGGER.error("Invalid set url passed, requires the base set url without query strings.") if (set_url.include?("?perSite="))
  raw = Nokogiri::HTML(Net::HTTP.get(URI(set_url)))
  return_urls = []

  url_format = set_url
  url_format += "?perSite=20&site=#{raw.css("div#pagination").css("a.dropdown-item").count.to_s}"
  raw.css("div#pagination").css("a.dropdown-item").map do |page|
    url_format.gsub(/site=[0-9]+/, "site=#{page.children.text}")
  end
end

def scrape_set(set_url)
  every_page(set_url).each do |page|
    LOGGER.info "Scraping set data from #{page}"
    raw = Nokogiri::HTML(Net::HTTP.get(URI(page)))
    raw.css('div[id^="productRow"]').each do |card|
      card_data = Hash.new
      card_data["card_name"] = card.css("div.col-10.col-md-8.px-2.flex-column.align-items-start.justify-content-center").text
      LOGGER.info "  Processing #{card_data["card_name"]}"
      card_data["card_url"] = card.css("a")[1]["href"]
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
  card_data = Hash.new
  seller_inv_data = Hash.new
  binding.pry
  # basic info
  card_data["available_inventory"] = raw.css("#tabContent-info > div > div.col-12.col-lg-6.mx-auto > div > div.info-list-container.col-12.col-md-8.col-lg-12.mx-auto.align-self-start > dl > dd:nth-child(8)").text
  card_data["lowest_eur"] = raw.css("#tabContent-info > div > div.col-12.col-lg-6.mx-auto > div > div.info-list-container.col-12.col-md-8.col-lg-12.mx-auto.align-self-start > dl > dd:nth-child(10)").text
  card_data["price_trend"] = raw.css("#tabContent-info > div > div.col-12.col-lg-6.mx-auto > div > div.info-list-container.col-12.col-md-8.col-lg-12.mx-auto.align-self-start > dl > dd:nth-child(12) > span").text
  card_data["thirty_day_average_price"] = raw.css("#tabContent-info > div > div.col-12.col-lg-6.mx-auto > div > div.info-list-container.col-12.col-md-8.col-lg-12.mx-auto.align-self-start > dl > dd:nth-child(14) > span").text
  card_data["seven_day_average_price"] = raw.css("#tabContent-info > div > div.col-12.col-lg-6.mx-auto > div > div.info-list-container.col-12.col-md-8.col-lg-12.mx-auto.align-self-start > dl > dd:nth-child(16) > span").text
  card_data["one_day_average_price"] = raw.css("#tabContent-info > div > div.col-12.col-lg-6.mx-auto > div > div.info-list-container.col-12.col-md-8.col-lg-12.mx-auto.align-self-start > dl > dd:nth-child(18) > span").text

  # foil info
  # repeat card data (trending by day, etc) for foils only, if available?
  raw.css('div[id^="articleRow"]').each do |row|
    seller_inv_data["seller_name"] = row[1].css("span.mr-1 > a").text
    seller_inv_data["seller_country"] = row[1].css("span.mr-1")[1]["title"]
    #seller_inv_data["seller_condition"]
    #seller_inv_data["card_language"]
    seller_inv_data["eur_price"] = row[1].css("div.flex-column").first.text
    #seller_inv_data["is_foil"]
    seller_inv_data["qty_available"] = row.("span.mr-3").text
    #seller_inv_data["seller_type"]
  end

end