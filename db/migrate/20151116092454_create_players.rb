class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :not_so_secret_id

      t.timestamps null: false
    end
  end
end