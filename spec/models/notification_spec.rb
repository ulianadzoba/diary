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
require 'rails_helper'

RSpec.describe Notification, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
