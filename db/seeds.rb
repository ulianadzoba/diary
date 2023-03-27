puts 'Create user'
2.times { FactoryBot.create(:user, :admin) }
FactoryBot.create_list(:user, 10)

puts 'Create categories'
Category::TYPES.each do |type|
  FactoryBot.create(:category, name: type)
end

puts 'Create journals'
User.all.find_each do |user| 
  2.times { FactoryBot.create :journal, :public, user: user, category: Category.all.sample }
  3.times { FactoryBot.create :journal, :public, :with_preview, user: user, category: Category.all.sample }
end

puts 'Create posts'
Journal.all.find_each do |journal|
  20.times { FactoryBot.create :post, journal: journal }
end


