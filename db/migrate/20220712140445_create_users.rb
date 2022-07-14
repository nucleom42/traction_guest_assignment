# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, null: false
      t.string :gov_id_number, null: false
      t.belongs_to :gov, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :users, %i[gov_id_number first_name last_name email], unique: true, name: 'index_unique_all_fields'
  end
end
