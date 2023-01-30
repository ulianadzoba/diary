class CreateJoinTableUsersJournals < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :journals do |t|
      t.index [:user_id, :journal_id]
    end
  end
end
