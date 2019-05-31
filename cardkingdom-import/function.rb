def function(response:, router:, database:)
  response.status = :ok
end

def update_buylist
end

def update_retail
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