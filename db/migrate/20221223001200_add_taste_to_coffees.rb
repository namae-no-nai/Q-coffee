class AddTasteToCoffees < ActiveRecord::Migration[7.0]
  def change
    add_reference :coffees, :origin, null: false, foreign_key: true
  end
end
