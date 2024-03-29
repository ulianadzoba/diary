# == Schema Information
#
# Table name: images
#
#  id             :bigint           not null, primary key
#  imageable_type :string
#  imageable_id   :integer
#  description    :text
#  file           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :image do
    file { Rack::Test::UploadedFile.new(Dir[Rails.root.join('spec', 'files', 'images', '*')].sample) }
  end
end
