# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  name       :string
#  title      :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  journal_id :bigint
#
class Post < ApplicationRecord
  belongs_to :journal
  has_many :images, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true

  validates :title, :content, presence: true

  scope :ordered, -> { order(created_at: :desc) }
end
