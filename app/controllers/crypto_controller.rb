class CryptoController < ApplicationController

  def index
# Scrap CoinMarketCap
    price = StartScrap.new.crypto_value
    name = StartScrap.new.crypto_name
    hash_crypto = StartScrap.new.create_hash(name, price)
    x = 0
    while hash_crypto[x]
      crypto_search = Crypto.find_by(name: hash_crypto[x]["Name"])

# Create crypto if doesnt exist yet
      if crypto_search == nil
        Crypto.create(name: hash_crypto[x]["Name"], value: hash_crypto[x]["Price"])

# Update crypto value if different
      elsif crypto_search.value != hash_crypto[x]["Price"]
        crypto_search.update(value: hash_crypto[x]["Price"])

# Do nothing if crypto exist with same value
      else
        puts 'Value not changed !'
      end
      x += 1
    end

=begin
    Crypto.destroy_all
    price = StartScrap.new.crypto_value
    name = StartScrap.new.crypto_name
    hash_crypto = StartScrap.new.create_hash(name, price)
    StartScrap.new.save(hash_crypto)
=end
    @crypto = Crypto.order(:name)
  end

  def show
    @crypto_id = params['crypto_id']
    link = "/show/" + @crypto_id
    redirect_to link
  end

  def display
    @cryp = params['id']
  end

end
