class CreatePackingLists < ActiveRecord::Migration[5.1]
  def change
    create_table :packing_lists do |t|
      t.string :item
      t.integer :quantity
      t.integer :trip_id

      t.timestamps
    end
  end
end
