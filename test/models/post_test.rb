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
require "test_helper"

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
