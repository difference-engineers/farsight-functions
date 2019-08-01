def function(response:, router:, database:)
  response.status = :ok
end

def set_ids
  url = "https://www.cardmarket.com/en/Magic/Products/Singles"

  raw = Nokogiri::HTML(Net::HTTP.get(URI(url)))
  raw.css('select[name=idExpansion]').css('option').each do |this|

  end

end