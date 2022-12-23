class AddUserToCoffees < ActiveRecord::Migration[7.0]
  def change
    add_reference :coffees, :user, null: false, foreign_key: true
  end
end