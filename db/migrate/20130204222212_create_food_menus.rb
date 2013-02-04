class CreateFoodMenus < ActiveRecord::Migration
  def change
    create_table :food_menus do |t|
      t.string :category
      t.string :name
      t.float :price

      t.timestamps
    end
  end
end