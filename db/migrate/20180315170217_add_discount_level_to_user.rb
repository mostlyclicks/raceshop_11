class AddDiscountLevelToUser < ActiveRecord::Migration[5.1]
  def change
  	add_column :spree_users, :discount_level, :string
  end
end
