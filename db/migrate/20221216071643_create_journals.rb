class CreateJournals < ActiveRecord::Migration[7.0]
  def change
    create_table :journals do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :private, default: true 

      t.timestamps
    end
  end
end
