FactoryBot.define do
  factory :notification do
    event { "MyString" }
    opened_at { "2020-07-16 03:11:26" }
    vaccine_id { 1 }
  end
end
