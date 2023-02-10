# == Schema Information
#
# Table name: tinymce_pictures
#
#  id         :bigint           not null, primary key
#  picture    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TinymcePicture < ApplicationRecord
  mount_uploader :picture, TinymcePictureUploader
end
