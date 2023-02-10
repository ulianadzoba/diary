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
FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    content { Faker::Lorem.paragraphs(number: 10).join }
    journal

    images { create_list(:image, 4, imageable: instance) }
  end
end
