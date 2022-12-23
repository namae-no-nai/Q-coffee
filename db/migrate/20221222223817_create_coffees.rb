class CreateCoffees < ActiveRecord::Migration[7.0]
  def change
    create_table :coffees do |t|
      t.string :name
      t.string :roast
      t.string :farm
      t.string :brand
      t.string :sensory
      t.string :taste

      t.timestamps
    end
  end
end
