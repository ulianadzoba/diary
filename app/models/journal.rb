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
#
class Journal < ApplicationRecord
  mount_uploader :preview, JournalPreviewUploader

  has_many :posts, dependent: :destroy
  has_and_belongs_to_many :users
  belongs_to :user

  validates :name, presence: true

  scope :ordered, -> { order(:name) }
  scope :shared, -> { where(private: false) }
end
