class CreateDrinkMenus < ActiveRecord::Migration
  def change
    create_table :drink_menus do |t|
      t.string :category
      t.string :name
      t.float :price

      t.timestamps
    end
  end
end
