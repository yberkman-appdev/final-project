class AddUserCreatedToPackingList < ActiveRecord::Migration[5.1]
  def change
    add_column :packing_lists, :user_created, :boolean
  end
end
