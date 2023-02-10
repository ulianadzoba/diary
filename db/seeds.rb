puts 'Create user'
2.times { FactoryBot.create(:user, :admin) }
FactoryBot.create_list(:user, 10)

puts 'Create journals'
User.all.find_each do |user| 
  2.times { FactoryBot.create :journal, :public, user: user }
  3.times { FactoryBot.create :journal, :public, :with_preview, user: user }
end

puts 'Create posts'
Journal.all.find_each do |journal|
  5.times { FactoryBot.create :post, journal: journal }
end

