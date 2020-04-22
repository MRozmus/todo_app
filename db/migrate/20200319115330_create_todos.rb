class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.integer :priority
      t.boolean :status
      t.references :guest
      t.references :user
      t.references :share

      t.timestamps
    end
  end
end
