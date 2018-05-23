class AddAthleteBrand < ActiveRecord::Migration[5.1]
  def change
  	add_column :spree_users, :athlete_brand, :string
  end
end
