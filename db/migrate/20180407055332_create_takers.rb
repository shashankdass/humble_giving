class CreateTakers < ActiveRecord::Migration[5.1]
  def change
    create_table :takers do |t|
      t.string :cross_street1
      t.string :cross_street2
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.string :country
      t.string :zipcode

      t.timestamps
    end
  end
end
