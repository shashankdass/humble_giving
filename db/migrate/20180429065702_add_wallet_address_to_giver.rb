class AddWalletAddressToGiver < ActiveRecord::Migration[5.1]
  def change
    add_column :givers, :wallet_address, :string
  end
end
