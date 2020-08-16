class Address < ApplicationRecord
  belongs_to :info_injection_book

  def ext_permanent_address
    permanent_address.to_s + ward&.name.to_s + district&.name.to_s + province&.name.to_s
  end

  def ext_current_address
    current_address.to_s + ward&.name.to_s + district&.name.to_s + province&.name.to_s
  end
end
