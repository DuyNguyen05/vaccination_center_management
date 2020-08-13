FactoryBot.define do
  factory :order do
    quantity { 1 }
    vaccine { nil }
    company { nil }
    account { nil }
  end
end
