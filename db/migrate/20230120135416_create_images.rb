class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.string :imageable_type
      t.integer :imageable_id
      t.text :description
      t.string :file

      t.timestamps
    end

    add_index :images, [:imageable_type, :imageable_id]
  end
end
