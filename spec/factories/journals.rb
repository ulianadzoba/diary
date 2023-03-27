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
FactoryBot.define do
  factory :journal do
    name { Faker::Book.title }
    description { Faker::Lorem.paragraphs(number: 8).join }
    user

    trait :public do
      private { false }
    end

    trait :with_preview do
      preview { Rack::Test::UploadedFile.new(Dir[Rails.root.join('spec', 'files', 'images', '*')].sample) }
    end
  end
end
