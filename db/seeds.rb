# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
unless AdminUser.exists?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end  

unless Page.exists?
  pages = ['Sākums', 'Dalībnieki', 'Par ziedojumiem', 'Vairāk par pasākumu', 'Noteikumi', 'Kontakti']
  pages.each_with_index do |page,index|
      Page.create(
        title: page, 
        visible: true,
        slug: "#{page.parameterize("-")}"
        )
  end  
end    

