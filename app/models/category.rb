# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  TRAVEL = 'Travel'.freeze
  FOOD = 'Food'.freeze
  CHILDREN = 'Children'.freeze
  FASHION = 'Fashion'.freeze
  OTHER = 'Other'.freeze

  TYPES = [TRAVEL, FASHION, FOOD, CHILDREN, OTHER].freeze

  has_many :journals

  validates :name, presence: true

  scope :ordered, -> { order(:name) }
end
