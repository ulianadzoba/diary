# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  message    :string           not null
#  seen       :boolean
#  type       :string           not null
#  user_id    :bigint           not null
#  journal_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class InviteAuthorNotification < Notification
end
