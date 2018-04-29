class AddAddressToGiver < ActiveRecord::Migration[5.1]
  def change
    add_column :givers, :address, :string
  end
end
