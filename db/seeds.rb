puts 'Create user'
2.times { FactoryBot.create(:user, :admin) }
FactoryBot.create_list(:user, 10)

puts 'Create journals'
User.all.each do |user| 
  5.times { FactoryBot.create :journal, :public, user: user }
end

puts 'Create posts'
Journal.all.each do |journal|
  5.times { FactoryBot.create :post, journal: journal }
end

