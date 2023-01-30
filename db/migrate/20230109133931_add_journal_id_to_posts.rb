class AddJournalIdToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :journal, null: true, foreign_key: true
  end
end
