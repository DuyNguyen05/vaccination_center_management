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

Role.create!([{role: "admin"}, {role: "super_admin"}, {role: "user"}, {role: "staff"}])

duy = DetailsInfo.create(first_name: "Duy", last_name: "Nguyen", identify: "12345678999", number_phone: "1234567890", email: "duynn.mta@gmail.com")
account = CreateAccountService.new(details_info_id: duy.id).create_account("true")
Account.find(account.id).update! user_code: "admin-070397"
Admin.find(account.id).update! user_code: "admin-070397"

30.times do |n|
  code = "#{n + 1}"
  name = Faker::Company.name

  Company.create!(company_code: code, name: name)
end

30.times do |n|
  code = Faker::Code.imei
  name = Faker::Beer.name
  manufacture = Faker::Beer.brand
  expiry_date = Faker::Date.between(from: Date.today, to: 1.year.from_now)
  content = Faker::Marketing.buzzwords
  quantity = Faker::Number.within(range: 1..50)
  company_code =  Company.pluck(:company_code).sample
  price = Faker::Number.decimal(l_digits: 6, r_digits: 1)

  Vaccine.create!(
    code: code, name: name, manufacture: manufacture, expiry_date: expiry_date, content: content, quantity: quantity, user_code: Admin.first.user_code, company_code: company_code, price: price
  )
end

thao = DetailsInfo.create(first_name: "Thao", last_name: "Nguyen", identify: "017270100", number_phone: "0389746397", email: "thaonguyen.mta@gmail.com")
account = CreateAccountService.new(details_info_id: thao.id).create_account
Account.find(account.id).update! user_code: "staff-12345"
VaccinationCenter.create! code: "VCC0009", address: "BlueDart Marthandam (K.K District) Tamil Nadu, IND", number_phone: "+23 323 43434"
10.times do |n|
  name = Faker::IndustrySegments.sector
  content = Faker::Lorem.word

  vaccine_package_type = VaccinePackageType.pluck(:name)
  while vaccine_package_type.include? name do
    name = Faker::IndustrySegments.sector
  end
  VaccinePackageType.create!(
    name: name, content: content
  )
end

50.times do |n|
  phone = InfoInjectionBook.pluck(:number_phone)
  father_name = Faker::Name.name_with_middle
  mother_name = Faker::Name.name_with_middle
  identify_mother = Faker::IDNumber.invalid_south_african_id_number
  identify_father = Faker::IDNumber.invalid_south_african_id_number
  number_phone = Faker::PhoneNumber.country_code
  while phone.include? number_phone do
    number_phone = Faker::PhoneNumber.country_code
  end
  current_address = Faker::Address.full_address
  permanent_address = Faker::Address.full_address
  email = Faker::Internet.email
  InfoInjectionBook.create!(father_name: father_name, identify_father: identify_father, mother_name: mother_name, identify_mother: identify_mother,
    number_phone: number_phone, current_address: current_address, permanent_address: permanent_address, email: email)

  name_person_injected = Faker::Name.name_with_middle
  date_of_birth = Faker::Date.between(from: 10.days.ago, to: Date.today)
  place_of_birth = permanent_address
  InjectionBook.create!(name_person_injected: name_person_injected, date_of_birth: date_of_birth, place_of_birth: place_of_birth, info_injection_book_id: n+1, gender: "male")
end
