# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  message    :string
#  seen       :boolean          default(FALSE)
#  type       :string           not null
#  user_id    :bigint           not null
#  journal_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Notification < ApplicationRecord
  INVITE_AUTHOR_NOTIFICATION = 'InviteAuthorNotification'.freeze
  
  belongs_to :user
  belongs_to :journal

  scope :unseen, -> { where(seen: false) }
  scope :for_user, -> (user){ where(user: user) }
  scope :ordered, -> { order(created_at: :desc) }

  def unseen?
    seen == false
  end
end
