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
FactoryBot.define do
  factory :journal do
    name { Faker::Book.title }
    description { Faker::Lorem.paragraphs(number: 3).join }
    user

    trait :public do
      private { false }
    end
  end
end
