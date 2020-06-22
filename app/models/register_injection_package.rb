class RegisterInjectionPackage < ApplicationRecord
  belongs_to :injection_book
  belongs_to :vaccine_package_type
  belongs_to :bill, optional: true
end
