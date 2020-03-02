class InjectionSchedule < ApplicationRecord
  belongs_to :vaccination_center
  belongs_to :vaccine_package
  belongs_to :book_code, class_name: InjectionBook.name
end
