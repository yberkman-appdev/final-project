class AddPackedToPackingList < ActiveRecord::Migration[5.1]
  def change
    add_column :packing_lists, :packed, :boolean
  end
end
