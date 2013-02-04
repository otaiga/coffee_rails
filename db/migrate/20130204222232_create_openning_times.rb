class CreateOpenningTimes < ActiveRecord::Migration
  def change
    create_table :openning_times do |t|
      t.string :weekday
      t.string :open_time
      t.string :close_time
      t.timestamps
    end
  end
end