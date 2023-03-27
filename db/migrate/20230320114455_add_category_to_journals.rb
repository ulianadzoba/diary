class AddCategoryToJournals < ActiveRecord::Migration[7.0]
  def change
    add_reference :journals, :category, null: false
  end
end
