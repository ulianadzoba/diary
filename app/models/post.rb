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
  has_one_attached :audio, dependent: :destroy

  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true

  validate :validate_audio_filetypes
  validates :title, :content, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  after_commit :clear_unattached_files

  private

  def clear_unattached_files
    ActiveStorage::Blob.unattached.find_each(&:purge_later)
  end

  def validate_audio_filetypes
    return unless audio.attached?

    unless audio.content_type.in?(%w[audio/x-wav audio/ogg])
      errors.add(:audio, 'must be a OGG, or WAV file')
    end
  end
end
