FactoryBot.define do
  factory :admin do
    user_code { "MyString" }
    email { "MyString" }
    password { "MyString" }
    role { nil }
  end
end
