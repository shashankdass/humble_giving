class AddColumnsToGiver < ActiveRecord::Migration[5.1]
  def change
    add_column :givers, :description, :string
    add_column :givers, :status, :string
  end
end
