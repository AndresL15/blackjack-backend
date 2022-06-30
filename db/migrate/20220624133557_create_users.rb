class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :token
      t.string :state
      t.string :cards, default: ""
      t.integer :points
      t.belongs_to :game
      
      t.timestamps
    end
  end
end
