class CreateLineupEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :lineup_entries do |t|
      t.references :lineup, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.integer :batting_order, null: false

      t.timestamps
    end
  end
end
