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
FactoryBot.define do
  factory :notification do
    type { Notification::INVITE_AUTHOR_NOTIFICATION }
    user
    journal

    trait :seen do
      seen { true }
    end
  end
end
