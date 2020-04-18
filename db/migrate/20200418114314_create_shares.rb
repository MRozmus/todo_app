class CreateShares < ActiveRecord::Migration[6.0]
  def change
    create_table :shares do |t|
      t.integer :sharer_id
      t.integer :relation_id
      t.integer :todo_id

      t.timestamps
    end
  end
end
