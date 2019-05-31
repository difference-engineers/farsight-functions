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
    raw.css('div#editionContainer').css('option').each do |set|
        sets.push set["value"].to_i, set.children.text
    end
    sets
end