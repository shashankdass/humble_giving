json.extract! taker, :id, :cross_street1, :cross_street2, :latitude, :longitude, :country, :zipcode, :created_at, :updated_at, :phone_number, :takers_name
json.url taker_url(taker, format: :json)
