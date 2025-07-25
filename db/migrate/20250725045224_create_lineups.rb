class CreateLineups < ActiveRecord::Migration[8.0]
  def change
    create_table :lineups do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.float :expected_score, default: 0.0

      t.timestamps
    end
  end
end
