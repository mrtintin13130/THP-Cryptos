require 'rubygems'
require 'nokogiri'
require 'open-uri'

class StartScrap
  def crypto_value
    page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
    x = 0
    price = Array.new
    var = page.css("a.price").each do |link|
      price[x] = link.text
      x += 1
    end
    return price
  end

  def crypto_name
    page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
    x = 0
    name = Array.new
    var = page.css("td.currency-name").each do |link|
      name[x] = link["data-sort"]
      x += 1
    end
    return name
  end

  def create_hash(name, price)
    x = 0
    hash_crypto = Hash.new
    while name[x]
      hash_crypto[x] = {
              "Name" => name[x],
              "Price" => price[x]
      }
      x += 1
    end
    return hash_crypto
  end


  def save(hash_crypto)
    x = 0
    while(hash_crypto[x])
      @crypto = Crypto.new(name: hash_crypto[x]["Name"], value: hash_crypto[x]["Price"])
      @crypto.save
      x += 1
    end
  end
end
