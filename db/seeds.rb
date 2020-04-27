# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 10.times do |n|
#   company_code = "#{n+1} code"
#   name = Faker::Company.name
#   address = Faker::Company.industry

#   Company.create(company_code: company_code, name: name, address: address)
# end

Role.create role: :admin
Role.create role: :super_admin
Role.create role: :user
Role.create role: :staff

30.times do |n|
  code = Faker::Code.imei
  name = Faker::Beer.name
  manufacture = Faker::Beer.brand
  expiry_date = Faker::Date.between(from: Date.today, to: 1.year.from_now)
  content = Faker::Marketing.buzzwords
  quantity = Faker::Number.within(range: 1..50)

  Vaccine.create!(
    code: code, name: name, manufacture: manufacture, expiry_date: expiry_date, content: content, quantity: quantity
  )
end

duy = DetailsInfo.create(first_name: "Duy", last_name: "Nguyen", identify: "12345678999", number_phone: "1234567890", email: "duynn.mta@gmail.com")
CreateAccountService.new(details_info_id: duy.id).create_account("true")

30.times do |n|
  code = "#{n + 1}"
  name = Faker::Company.name

  Company.create!(company_code: code, name: name)
end
