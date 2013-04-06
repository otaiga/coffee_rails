class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.string :prize_stat
      t.string :prize
      t.timestamps
    end
  end
end
