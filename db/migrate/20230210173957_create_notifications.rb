class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :message
      t.boolean :seen, default: false
      t.string :type, null: false
      t.references :user, null: false
      t.references :journal

      t.timestamps
    end
  end
end
