class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.string :player, null: false
      t.integer :score, null: false
      t.datetime :time, null: false
    end
    add_index :scores, [:player, :time]
    add_index :scores, [:time]
  end
end
