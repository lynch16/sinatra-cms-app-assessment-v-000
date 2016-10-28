class CreateEntities < ActiveRecord::Migration[5.0]
  def change
      create_table :entities do |t|
          t.string :name
          t.string :state
          t.string :type
          t.string :structure
          t.string :signor
          t.string :signor_title
          t.integer :loan_id
      end
  end
end
