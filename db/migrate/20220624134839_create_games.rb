class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :name
      t.string :deck
      t.string :state
      t.string :winner

      t.timestamps
    end
  end
end
