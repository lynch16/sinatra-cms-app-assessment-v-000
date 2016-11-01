class CreateEntities < ActiveRecord::Migration[5.0]
  def change
      create_table :entities do |t|
          t.string :name
          t.string :entity_type
          t.string :structure
          t.integer :loan_id
          t.integer :user_id
      end
  end
end
