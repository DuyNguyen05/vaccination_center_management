class RegisterInjectionPackage < ApplicationRecord
  belongs_to :injection_book
  belongs_to :vaccine_package
  belongs_to :bill
end
