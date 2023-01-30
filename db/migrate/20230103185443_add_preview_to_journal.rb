class AddPreviewToJournal < ActiveRecord::Migration[7.0]
  def change
    add_column :journals, :preview, :string
  end
end
