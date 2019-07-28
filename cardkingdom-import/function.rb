def function(response:, router:, database:)
  response.status = :ok
end

def update_buylist
  base_url = "https://cardkingdom.com/purchasing/mtg_singles?filter%5Bsort%5D=n"\
  "ame&filter%5Bsearch%5D=mtg_advanced&filter%5Bname%5D=&filter%5Bcategory_id%5D"\
  "=2864&filter%5Bfoil%5D=1&filter%5Bnonfoil%5D=1&filter%5Bprice_op%5D=&filter%5"\
  "Bprice%5D="

  LOGGER.info("Starting update of buylist cardkingdom prices..")

  category_urls(base_url).each do |category_url|
    LOGGER.info(".. Processing #{category_url}.")
    every_page(category_url).each do |page|
      LOGGER.info(".... Processing page #{page}.")
      parse_buylist(page)
    end
  end
end

def update_retail
  base_url = "https://www.cardkingdom.com/mtg/5th-edition?filter%5Bipp%5D=60&fi\
  lter%5Bsort%5D=name"

  LOGGER.info("Starting update of retail cardkingdom prices.")

  category_urls(base_url).each do |category_url|
    LOGGER.info(".. Processing #{category_url}.")
    every_page(category_url).each do |page|
      LOGGER.info(".... Processing page #{page}.")
      parse_retail(page)
    end
  end
end

def set_ids()
  url = "https://cardkingdom.com/search/mtg"

  raw = Nokogiri::HTML(Net::HTTP.get(URI(url)))
  set_ids = []
  discard = ["All Editions", "Standard", "Modern"]
  raw.css("div#editionContainer").css("option").each do |set|
    set_ids.push(Integer(set["value"], 10)) unless discard.include?(set.children.text)
  end
  set_ids
end

def category_urls(base_url)
  set_ids().map do |set_id|
    base_url.gsub(/category_id%5D=([0-9]+)/i, "category_id%5D=#{set_id}")
  end
end

def parse_buylist(url)
  #vendor = find(:vendors, :slug => "cardkingdom")

  raw = Nokogiri::HTML(Net::HTTP.get(URI(url)))
  raw.css("div.itemContentWrapper").each do |card|
    cardname = card.css("span.productDetailTitle").inner_text
    raw_set      = card.css("div.productDetailSet").css("a").inner_text.strip
    cash_dollars = card.css(".usdSellPrice").css("span.sellDollarAmount").inner_text
    cash_cents   = card.css(".usdSellPrice").css("span.sellCentsAmount").inner_text
    parsed_set   = raw_set.split(/\((C|U|R|M|P|S)\)/)
    set          = parsed_set[0]
    foil         = parsed_set[2]
    foil.nil? ? foil = "0" : foil = "1"
    cash         = cash_dollars + "." + cash_cents
    #sell         = monetize.parse(cash)

    #card = find(table, {})
    #insert(:card_sell_prices, card, :sell_cents => sell.cents, :sell_currency => sell.currency, :reported_condition => reported_condition, :vendor => vendor)
  end
end


def parse_retail(url)

  raw = Nokogiri::HTML(Net::HTTP.get(URI(url)))
  raw.css("div.itemContentWrapper").each do |card|
    # add handling for unusual cards: prerelease promos, con promos, buy a box, etc
    cardname     = card.css("span.productDetailTitle").text
    raw_set      = card.css("div.productDetailSet").text.strip
    parsed_set   = raw_set.split(/\((C|U|R|M|P|S)\)/)
    set          = parsed_set[0]

    nm_inventory = card.css("ul.addToCartByType").css("li.NM").css("div.amtAndPrice").css("span.styleQty").inner_text
    nm_price     = card.css("ul.addToCartByType").css("li.NM").css("div.amtAndPrice").css("span.stylePrice").inner_text.strip

    ex_inventory = card.css("ul.addToCartByType").css("li.EX").css("div.amtAndPrice").css("span.styleQty").inner_text
    ex_price     = card.css("ul.addToCartByType").css("li.EX").css("div.amtAndPrice").css("span.stylePrice").inner_text.strip

    vg_inventory = card.css("ul.addToCartByType").css("li.VG").css("div.amtAndPrice").css("span.styleQty").inner_text.strip
    vg_price     = card.css("ul.addToCartByType").css("li.VG").css("div.amtAndPrice").css("span.stylePrice").inner_text.strip

    g_inventory = card.css("ul.addToCartByType").css("li.G").css("div.amtAndPrice").css("span.styleQty").inner_text.strip
    g_price     = card.css("ul.addToCartByType").css("li.G").css("div.amtAndPrice").css("span.stylePrice").inner_text.strip
  end
end

def every_page(url)
  every_page = []

  raw = Nokogiri::HTML(Net::HTTP.get(URI(url)))

  count = raw.css("ul.pagination").css("li").count
  pages = Integer(raw.css("ul.pagination").css("li")[count - 2].children.text.strip, 10)

  (1..pages).each do |page|
    every_page.push(url + "&page=#{page}")
  end
  separate_foil_pages = true unless url.include?("/purchasing/")
  foil_url = url.sub(%r(/singles), "/foils") if separate_foil_pages

  foil_raw = Nokogiri::HTML(Net::HTTP.get(URI(url)))

  foil_count = raw.css("ul.pagination").css("li").count
  foil_pages = Integer(raw.css("ul.pagination").css("li")[count - 2].children.text.strip, 10)

  (1..foil_pages).each do |page|
    every_page.push(url + "&page=#{page}")
  end
  every_page
end
