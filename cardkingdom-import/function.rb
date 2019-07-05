def function(response:, router:, database:)
  response.status = :ok
end

def update_buylist
  categories = categories()
  categories.each do |category|
    # process every page in category
  end
end

def update_retail
  categories = categories()
  categories.each do |category|
  # process every page in category
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
  temp_url = "https://cardkingdom.com/catalog/view?filter%5Bipp%5D=60&filter%5Bsort%5D=most_popular&filter%5Bsearch%5D=mtg_advanced&filter%5Bcategory_id%5D=3058&filter%5Bmulti%5D%5B0%5D=1&filter%5Btype_mode%5D=any&filter%5Bmanaprod_select%5D=any"

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

def next_page(raw_nokogiri)
  # search for pagination element with "»"
  last_li = raw_nokogiri.css('li.pagination').last.inner_text
  url = raw_nokogiri.css('li.pagination').last.href
  url if last_li == "»" else false end
end