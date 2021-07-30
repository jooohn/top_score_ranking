class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.string :player
      t.integer :score
      t.datetime :time
    end
  end
end
