class CreateShares < ActiveRecord::Migration[6.0]
  def change
    create_table :shares do |t|
      t.references :sender
      t.references :recipient

      t.timestamps
    end
    add_foreign_key :shares, :users, column: :sender_id, primary_key: :id
    add_foreign_key :shares, :users, column: :recipient_id, primary_key: :id
  end
end
