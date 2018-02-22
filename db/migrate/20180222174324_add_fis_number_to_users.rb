class AddFisNumberToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :spree_users, :fis_number, :string
  end
end
