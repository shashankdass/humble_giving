class AddNameToTakers < ActiveRecord::Migration[5.1]
  def change
    add_column :takers, :takers_name, :string
  end
end
