class CreateGovs < ActiveRecord::Migration[7.0]
  def change
    create_table :govs do |t|
      t.string :gov_id_type, default: 'ID', null: false, index: { unique: true }
      t.string :description

      t.timestamps
    end
  end
end
