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
require "test_helper"

class JournalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
