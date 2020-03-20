class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.integer :priority
      t.boolean :status
      t.references :guest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
