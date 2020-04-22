class CreateRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :relations do |t|
      t.references :sender
      t.references :recipient
      t.boolean :status, default: false

      t.timestamps
    end
    add_foreign_key :relations, :users, column: :sender_id, primary_key: :id
    add_foreign_key :relations, :users, column: :recipient_id, primary_key: :id
  end
end
