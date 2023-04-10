# == Schema Information
#
# Table name: journals
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :text
#  private     :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#  preview     :string
#  category_id :bigint           not null
#
class Journal < ApplicationRecord
  extend Pagy::Searchkick
  mount_uploader :preview, JournalPreviewUploader
  
  has_many :posts, dependent: :destroy
  has_and_belongs_to_many :users
  belongs_to :category
  belongs_to :user

  validates :name, presence: true

  scope :ordered, -> { order(:created_at) }
  scope :shared, -> { where(private: false) }

  searchkick text_middle: %i[name description]
end
