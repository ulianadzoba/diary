class CreateTinymcePictures < ActiveRecord::Migration[7.0]
  def change
    create_table :tinymce_pictures do |t|
      t.string :picture

      t.timestamps
    end
  end
end
