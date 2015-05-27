 require 'faker'
 
admin = User.new(
   # name:     'Admin User',
   email:    'admin@example.com',
   password: 'helloworld',
   role:     'admin'
 )
 admin.skip_confirmation!
 admin.save!


 # Create Wikis
 50.times do
   Wiki.create!(
     title:  Faker::Lorem.sentence,
     body:   Faker::Lorem.paragraph
   )
 end
 wikis = Wiki.all
 
 # # Create Comments
 # 100.times do
 #   Comment.create!(
 #     wiki: wikis.sample,
 #     body: Faker::Lorem.paragraph
 #   )
 # end
 
 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"
 # puts "#{Comment.count} comments created"