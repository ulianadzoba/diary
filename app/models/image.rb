# == Schema Information
#
# Table name: images
#
#  id             :bigint           not null, primary key
#  imageable_type :string
#  imageable_id   :integer
#  description    :text
#  file           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Image < ApplicationRecord
  mount_uploader :file, ImageUploader

  belongs_to :imageable, polymorphic: true
  
  validates :file, presence: true
  validates :description, length: { maximum: 150 }, allow_blank: true
end
