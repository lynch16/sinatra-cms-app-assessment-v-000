class CreateLoans < ActiveRecord::Migration[5.0]
  def change
      create_table :loans do |t|
          t.string :name
          t.string :number
          t.integer :amount
          t.integer :user_id
          t.timestamps
      end
  end
end
