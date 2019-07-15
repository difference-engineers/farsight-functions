def function(response:, router:, database:)
  response.status = :ok
end

def update_buylist
  categories().each do |category|
    every_page().each do |page|
      cards.each do |card|
      end
    end
  end
end

def update_retail
  categories().each do |category|
    every_page().each do |page|
      cards.each do |card|
      end
    end
  end
end

def categories
  url = "https://cardkingdom.com/search/mtg"

  raw = Nokogiri::HTML(Net::HTTP.get(URI(url)))
  sets = []
  discard = ["All Editions", "Standard", "Modern"]
  raw.css('div#editionContainer').css('option').each do |set|
    if !(discard.include?(set.children.text))
      sets.push set["value"].to_i, set.children.text.strip
  end
  sets
end

def parse_buylist(url)
  puts "parsing #{url}\n"

  raw = Nokogiri::HTML(Net::HTTP.get(URI(url)))
  raw.css('div.itemContentWrapper').each do |card|

    cardname     = card.css('span.productDetailTitle').inner_text
    raw_set      = card.css('div.productDetailSet').css('a').inner_text.strip
    cash_dollars = card.css('.usdSellPrice').css('span.sellDollarAmount').inner_text
    cash_cents   = card.css('.usdSellPrice').css('span.sellCentsAmount').inner_text
    parsed_set   = raw_set.split(/\((C|U|R|M|P|S)\)/)
    set          = parsed_set[0]
    foil         = parsed_set[2]
    foil         = (foil == nil) ? "0" : "1"
    cash         = cash_dollars + "." + cash_cents

    puts cardname, set, cash, "foil: " + foil, "\n"
  end
end

def parse_retail(url)

  raw = Nokogiri::HTML(Net::HTTP.get(URI(url)))
  raw.css('div.itemContentWrapper').each do |card|
    # add handling for unusual cards: prerelease promos, con promos, buy a box, etc
    cardname     = card.css('span.productDetailTitle').text
    raw_set      = card.css('div.productDetailSet').text.strip
    parsed_set   = raw_set.split(/\((C|U|R|M|P|S)\)/)
    set          = parsed_set[0]

    nm_inventory = card.css('ul.addToCartByType').css('li.NM').css('div.amtAndPrice').css('span.styleQty').inner_text
    nm_price     = card.css('ul.addToCartByType').css('li.NM').css('div.amtAndPrice').css('span.stylePrice').inner_text.strip

    ex_inventory = card.css('ul.addToCartByType').css('li.EX').css('div.amtAndPrice').css('span.styleQty').inner_text
    ex_price     = card.css('ul.addToCartByType').css('li.EX').css('div.amtAndPrice').css('span.stylePrice').inner_text.strip

    vg_inventory = card.css('ul.addToCartByType').css('li.VG').css('div.amtAndPrice').css('span.styleQty').inner_text.strip
    vg_price     = card.css('ul.addToCartByType').css('li.VG').css('div.amtAndPrice').css('span.stylePrice').inner_text.strip

    g_inventory = card.css('ul.addToCartByType').css('li.G').css('div.amtAndPrice').css('span.styleQty').inner_text.strip
    g_price     = card.css('ul.addToCartByType').css('li.G').css('div.amtAndPrice').css('span.stylePrice').inner_text.strip
  end
end

def every_page(url)
  every_page = []

  raw = Nokogiri::HTML(Net::HTTP.get(URI(url)))

  count = raw.css('ul.pagination').css('li').count
  pages = raw.css('ul.pagination').css('li')[count - 2].children.text.strip.to_i

  (1..pages).each do |page|
      every_page.push(url + "&page=#{page}")
  end

  separate_foil_pages = true unless url.include? "/purchasing/"
  if (separate_foil_pages)
    foil_url = url.sub(\/singles, "/foils")
  end

  foil_raw = Nokogiri::HTML(Net::HTTP.get(URI(url)))

  foil_count = raw.css('ul.pagination').css('li').count
  foil_pages = raw.css('ul.pagination').css('li')[count - 2].children.text.strip.to_i

  (1..foil_pages).each do |page|
      every_page.push(url + "&page=#{page}")
  end
end