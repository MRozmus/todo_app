class CreateRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :relations do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
