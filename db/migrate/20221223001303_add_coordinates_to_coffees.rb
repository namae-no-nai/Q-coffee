class AddCoordinatesToCoffees < ActiveRecord::Migration[7.0]
  def change
    add_column :coffees, :latitude, :float
    add_column :coffees, :longitude, :float
    add_column :coffees, :address, :string
    add_column :coffees, :location, :string
    add_column :coffees, :store, :string
  end
end
