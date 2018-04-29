class RemoveCrossStreetFromGiverTable < ActiveRecord::Migration[5.1]
  def change
    remove_columns :givers, :cross_street1, :cross_street2
  end
end
