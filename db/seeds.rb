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

Role.create!([{role: "admin"}, {role: "super_admin"}, {role: "user"}, {role: "staff"}, {role: "doctor"}, {role: "nurse"}])

duy = DetailsInfo.create(first_name: "Duy", last_name: "Nguyen", identify: "12345678999", number_phone: "1234567890", email: "duynn.mta@gmail.com", check_info: false)
account = CreateAccountService.new(details_info_id: duy.id).create_account("true")
Account.find(account.id).update! user_code: "admin-070397"
Admin.find(account.id).update! user_code: "admin-070397"

VaccineType.create! name: "Vắc xin phòng bệnh Thủy đậu"
VaccineType.create! name: "Vắc xin phòng bệnh Sởi-Quai bị-Rubella"
VaccineType.create! name: "Vắc xin phòng bệnh Viêm gan B"

30.times do |n|
  code = "#{n + 1}"
  name = Faker::Company.name

  Company.create!(company_code: code, name: name)
end

2.times do |n|
  code = Faker::Code.imei
  name = Faker::Beer.name
  manufacture = Faker::Beer.brand
  expiry_date = Faker::Date.between(from: Date.today, to: 1.year.from_now)
  content = Faker::Marketing.buzzwords
  quantity = Faker::Number.within(range: 1..50)
  company_code =  Company.pluck(:company_code).sample
  price = Faker::Number.decimal(l_digits: 6, r_digits: 1)

  vaccine = Vaccine.create!(
    code: code, name: name, manufacture: manufacture, expiry_date: expiry_date, content: content, quantity: quantity, user_code: Admin.first.user_code, company_code: company_code, saleprice: price, vaccine_type_id: 1
  )

  NumberInjection.create!(name: "Mũi 1", age: 5, vaccine_id: vaccine.id)
  NumberInjection.create!(name: "Mũi 2", age: 12, vaccine_id: vaccine.id)
  NumberInjection.create!(name: "Mũi 3", age: 48, vaccine_id: vaccine.id)
  NumberInjection.create!(name: "Mũi 4", age: 36, vaccine_id: vaccine.id)
end

thao = DetailsInfo.create(first_name: "Thao", last_name: "Nguyen", identify: "017270100", number_phone: "0389746397", email: "thaonguyen.mta@gmail.com", check_info: false)
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

10.times do |n|
  phone = DetailsInfo.pluck(:number_phone)
  first_name = Faker::Name.name_with_middle
  last_name = Faker::Name.name_with_middle
  identify = Faker::IDNumber.invalid_south_african_id_number

  number_phone = Faker::PhoneNumber.phone_number_with_country_code
  while phone.include? number_phone do
    number_phone = Faker::PhoneNumber.phone_number_with_country_code
  end
  current_address = Faker::Address.full_address
  permanent_address = Faker::Address.full_address
  email = Faker::Internet.email
  detail_info = DetailsInfo.create!(first_name: first_name, last_name: last_name, identify: identify, number_phone: number_phone, email: email, check_info: false)

  account = CreateAccountService.new(details_info_id: detail_info.id).create_account
  Account.find(account.id).update! user_code: "doctor-" + account.user_code.split("-")[1], role_id: 5
end

10.times do |n|
  phone = DetailsInfo.pluck(:number_phone)
  first_name = Faker::Name.name_with_middle
  last_name = Faker::Name.name_with_middle
  identify = Faker::IDNumber.invalid_south_african_id_number

  number_phone = Faker::PhoneNumber.phone_number_with_country_code
  while phone.include? number_phone do
    number_phone = Faker::PhoneNumber.phone_number_with_country_code
  end
  current_address = Faker::Address.full_address
  permanent_address = Faker::Address.full_address
  email = Faker::Internet.email
  detail_info = DetailsInfo.create!(first_name: first_name, last_name: last_name, identify: identify, number_phone: number_phone, email: email, check_info: false)

  account = CreateAccountService.new(details_info_id: detail_info.id).create_account
  Account.find(account.id).update! user_code: "nurse-" + account.user_code.split("-")[1], role_id: 6
end

10.times do |n|
  phone = DetailsInfo.pluck(:number_phone)
  first_name = Faker::Name.name_with_middle
  last_name = Faker::Name.name_with_middle
  identify = Faker::IDNumber.invalid_south_african_id_number

  number_phone = Faker::PhoneNumber.phone_number_with_country_code
  while phone.include? number_phone do
    number_phone = Faker::PhoneNumber.phone_number_with_country_code
  end
  current_address = Faker::Address.full_address
  permanent_address = Faker::Address.full_address
  email = Faker::Internet.email
  detail_info = DetailsInfo.create!(first_name: first_name, last_name: last_name, identify: identify, number_phone: number_phone, email: email, check_info: false)

  account = CreateAccountService.new(details_info_id: detail_info.id).create_account
  Account.find(account.id).update! user_code: "staff-" + account.user_code.split("-")[1], role_id: 4
end

50.times do |n|
  phone = InfoInjectionBook.pluck(:number_phone)
  father_name = Faker::Name.name_with_middle
  mother_name = Faker::Name.name_with_middle
  guardian_name = Faker::Name.name_with_middle
  identify_mother = Faker::IDNumber.invalid_south_african_id_number
  identify_father = Faker::IDNumber.invalid_south_african_id_number
  identify_guardian = Faker::IDNumber.invalid_south_african_id_number

  number_phone = Faker::PhoneNumber.phone_number_with_country_code
  while phone.include? number_phone do
    number_phone = Faker::PhoneNumber.phone_number_with_country_code
  end
  current_address = Faker::Address.full_address
  permanent_address = Faker::Address.full_address
  email = Faker::Internet.email
  InfoInjectionBook.create!(father_name: father_name, identify_father: identify_father, mother_name: mother_name, identify_mother: identify_mother,
    number_phone: number_phone, email: email, guardian_name: guardian_name, identify_guardian: identify_guardian, check_info: false )

  name_person_injected = Faker::Name.name_with_middle
  date_of_birth = Faker::Date.between(from: 10.days.ago, to: Date.today)
  place_of_birth = permanent_address
  InjectionBook.create!(name_person_injected: name_person_injected, date_of_birth: date_of_birth, place_of_birth: place_of_birth, info_injection_book_id: n+1, gender: "male")
end

5.times do |n|
  doctor_id = Account.where(role: 5).first.id
  cashier_id = Account.where(role: 4).first.id
  nurse_id = Account.where(role: 4).second.id
  check_before_injection = CheckBeforeInjection.create! answer_question: ["false", "false", "false", "false", "false", "false", "false", "false"]
  detail_injection_book = DetailInjectionBook.create!(injection_date: Time.now, react_after_injection: "AAAAAAAAAAAAAAA", time_after_injection: Time.now + 30*60, status: "step_5", injection_book_id: 1, check_before_injection_id: check_before_injection.id)
  bill = Bill.create!(creation_time: Time.now, doctor_id: doctor_id, cashier_id: cashier_id, nurse_id: nurse_id, payment_time: Time.now, injection_book_id: 1, total_money: 1200000, detail_injection_book_id: detail_injection_book.id)
  DetailBill.create! vaccine_id: 1, number_injection: 1, bill_id: bill.id, next_appointment: 10.days.from_now
end

5.times do |n|
  doctor_id = Account.where(role: 5).first.id
  cashier_id = Account.where(role: 4).first.id
  nurse_id = Account.where(role: 4).second.id
  check_before_injection = CheckBeforeInjection.create! answer_question: ["false", "false", "false", "false", "false", "false", "false", "false"]
  detail_injection_book = DetailInjectionBook.create!(injection_date: Time.now, react_after_injection: "AAAAAAAAAAAAAAA", time_after_injection: Time.now + 30*60, status: "step_5", injection_book_id: 1, check_before_injection_id: check_before_injection.id)
  bill = Bill.create!(creation_time: Time.now, doctor_id: doctor_id, cashier_id: cashier_id, nurse_id: nurse_id, payment_time: Time.now, injection_book_id: 2, total_money: 1200000, detail_injection_book_id: detail_injection_book.id)
  DetailBill.create! vaccine_id: 1, number_injection: 1, bill_id: bill.id, next_appointment: 10.days.from_now
end

5.times do |n|
  doctor_id = Account.where(role: 5).first.id
  cashier_id = Account.where(role: 4).first.id
  nurse_id = Account.where(role: 4).second.id
  check_before_injection = CheckBeforeInjection.create! answer_question: ["false", "false", "false", "false", "false", "false", "false", "false"]
  detail_injection_book = DetailInjectionBook.create!(injection_date: Time.now, react_after_injection: "AAAAAAAAAAAAAAA", time_after_injection: Time.now + 30*60, status: "step_5", injection_book_id: 1, check_before_injection_id: check_before_injection.id)
  bill = Bill.create!(creation_time: Time.now, doctor_id: doctor_id, cashier_id: cashier_id, nurse_id: nurse_id, payment_time: Time.now, injection_book_id: 3, total_money: 1200000, detail_injection_book_id: detail_injection_book.id)
  DetailBill.create! vaccine_id: 1, number_injection: 1, bill_id: bill.id, next_appointment: 10.days.from_now
end

5.times do |n|
  doctor_id = Account.where(role: 5).first.id
  cashier_id = Account.where(role: 4).first.id
  nurse_id = Account.where(role: 4).second.id
  check_before_injection = CheckBeforeInjection.create! answer_question: ["false", "false", "false", "false", "false", "false", "false", "false"]
  detail_injection_book = DetailInjectionBook.create!(injection_date: Time.now, react_after_injection: "AAAAAAAAAAAAAAA", time_after_injection: Time.now + 30*60, status: "step_5", injection_book_id: 1, check_before_injection_id: check_before_injection.id)
  bill = Bill.create!(creation_time: Time.now, doctor_id: doctor_id, cashier_id: cashier_id, nurse_id: nurse_id, payment_time: Time.now, injection_book_id: 4, total_money: 1200000, detail_injection_book_id: detail_injection_book.id)
  DetailBill.create! vaccine_id: 1, number_injection: 1, bill_id: bill.id, next_appointment: 10.days.from_now
end

5.times do |n|
  doctor_id = Account.where(role: 5).first.id
  cashier_id = Account.where(role: 4).first.id
  nurse_id = Account.where(role: 4).second.id
  check_before_injection = CheckBeforeInjection.create! answer_question: ["false", "false", "false", "false", "false", "false", "false", "false"]
  detail_injection_book = DetailInjectionBook.create!(injection_date: Time.now, react_after_injection: "AAAAAAAAAAAAAAA", time_after_injection: Time.now + 30*60, status: "step_5", injection_book_id: 1, check_before_injection_id: check_before_injection.id)
  bill = Bill.create!(creation_time: Time.now, doctor_id: doctor_id, cashier_id: cashier_id, nurse_id: nurse_id, payment_time: Time.now, injection_book_id: 1, total_money: 1200000, detail_injection_book_id: detail_injection_book.id)
  DetailBill.create! vaccine_id: 2, number_injection: 1, bill_id: bill.id, next_appointment: 10.days.from_now
end

require 'csv'

Province.transaction do
  # ActiveRecord::Base.connection.execute("TRUNCATE table provinces")

  CSV.foreach(Rails.root.join('db', 'master_data', 'provinces.csv'), headers: true) do |row|
    attrs = row.to_h.symbolize_keys
    Province.create!(attrs)
  end
end

District.transaction do
  # ActiveRecord::Base.connection.execute("TRUNCATE table districts")

  CSV.foreach(Rails.root.join('db', 'master_data', 'districts.csv'), headers: true) do |row|
    attrs = row.to_h.symbolize_keys
    District.create!(attrs)
  end
end

Ward.transaction do
  # ActiveRecord::Base.connection.execute("TRUNCATE table districts")

  CSV.foreach(Rails.root.join('db', 'master_data', 'wards.csv'), headers: true) do |row|
    attrs = row.to_h.symbolize_keys
    Ward.create!(attrs)
  end
end

Template.create! content: "<div class='row'><div class='col-xl-12 col-lg-12'><div class='card shadow mb-4'><div class='card-body'><div class='container border border-secondary rounded'> <div class='row mt-5 mb-5 ml-1 mr-1'> <div class='well col-xs-12 col-sm-12 col-md-12 col-xs-offset-1 col-sm-offset-1 col-md-offset-3'> <div class='row'> <div class='col-xs-6 col-sm-6 col-md-6'> <address> <strong>Trung tâm tiêm chủng Quốc Tế</strong> <br>{{vaccination_center_address}}<br> <abbr title='Phone'>Liên hệ:</abbr> {{number_phone}} </address> </div> <div class='col-xs-6 col-sm-6 col-md-6 text-right'> <p> <em>Thời gian tạo: {{time_now}}</em> </p> <p> <em>Mã hóa đơn #: {{bill_code}}</em> </p> </div> </div> <div class='row'> <div class='col-xs-12 col-sm-12 col-md-12 text-center'> <h1>Phiếu thu</h1> </div> <div class='col-xs-6 col-sm-6 col-md-6 '> <div class='text-gray float-left '> Họ và tên khách hàng tiêm: <b class='text-uppercase'> {{injection_book_name}} </b><br> Địa chỉ: {{current_address}}<br> </div> </div> <div class='col-xs-3 col-sm-3 col-md-3'> <div class='text-gray float-left '> Ngày sinh: {{date_of_birth}}<br> </div> </div> <div class='col-xs-3 col-sm-3 col-md-3 mb-3'> <div class='text-gray float-left '> Giới tính: {{gender}} <br> Điện thoại: {{number_phone_injection_book}}<br> </div> </div> <table class='table table-hover'> <thead> <tr> <th class='col-md-5'>Tên Vắc-xin</th> <th>Liều lượng</th> <th>Số lượng</th> <th>Hạn dùng</th> <th>Đơn giá</th> <th>Thành tiền</th> </tr> </thead> <tbody> {{detail_injection_book}}<tr> <td> <p> Tổng: </p></td> <td> &nbsp; </td> <td> <p>{{number_injections}}</p><p></p> </td> <td>&nbsp;</td> <td>&nbsp;</td> <td> <p> <strong>{{amount}}</strong> </p></td> </tr><tr> <td class='text-left'><h4><strong>Tiền thanh toán:&nbsp;</strong></h4></td> <td> &nbsp; </td> <td> &nbsp; </td> <td> &nbsp; </td> <td> &nbsp; </td> <td class='text-danger'><h4><strong>{{total_price}}</strong></h4></td> </tr> </tbody> </table> <div class='col-xs-3 col-sm-3 col-md-3 text-center'> <h7><strong>Bác sĩ chỉ định</strong></h7><br><br>{{doctor_name}}</div> <div class='col-xs-3 col-sm-3 col-md-3 text-center'> <h7><strong>Y tá phụ trách</strong></h7><br><br>{{nurse_name}}</div> <div class='col-xs-3 col-sm-3 col-md-3 text-center'> <h7><strong>Người lập phiếu thu</strong></h7><br><br>{{cashier_name}}</div> <div class='col-xs-3 col-sm-3 col-md-3 text-center'> <h7><strong>Người nộp tiền</strong></h7><br><br></div> </div> </div> </div> </div></div></div></div></div>"
