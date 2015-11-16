class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :player_32_id

      t.timestamps null: false
    end
  end
end
