# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  avatar                 :string
#  role                   :string           default("user"), not null
#  provider               :string
#  uid                    :string
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#factories' do
    it 'has valid factory' do
      expect(create(:user)).to be_valid
    end
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
  end

  describe 'associations' do
  end
end
