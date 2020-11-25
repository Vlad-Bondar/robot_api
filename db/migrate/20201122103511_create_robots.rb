class CreateRobots < ActiveRecord::Migration[6.0]
  def change
    create_table :robots do |t|
      t.string :facing
      t.integer :x
      t.integer :y
      t.timestamps
    end
  end
end
