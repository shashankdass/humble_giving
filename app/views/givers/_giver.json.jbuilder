json.extract! giver, :id, :cross_street1, :cross_street2, :latitude, :longitude, :country, :zipcode, :created_at, :updated_at, :description, :status
json.url giver_url(giver, format: :json)
