class AddUserToJournal < ActiveRecord::Migration[7.0]
  def change
    add_reference :journals, :user, null: true, foreign_key: true
  end
end
