class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.string :team
      t.string :position
      t.string :description

      t.float :stat_1b, null: false, default: 0.0
      t.float :stat_2b, null: false, default: 0.0
      t.float :stat_3b, null: false, default: 0.0
      t.float :stat_hr, null: false, default: 0.0
      t.float :stat_out, null: false, default: 1.0

      t.timestamps
      t.references :user, null: false, foreign_key: true
    end
  end
end
