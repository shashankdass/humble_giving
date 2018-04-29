json.extract! giver, :id, :address, :latitude, :longitude, :country, :zipcode, :created_at, :updated_at, :description, :status, :wallet_address
json.url giver_url(giver, format: :json)
