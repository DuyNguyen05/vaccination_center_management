class Address < ApplicationRecord
  before_create :destroy_address

  belongs_to :info_injection_book
  belongs_to :province, class_name: Province.name, optional: true
  belongs_to :district, class_name: District.name, optional: true
  belongs_to :ward, class_name: Ward.name, optional: true

  def ext_permanent_address
    permanent_address.to_s + " " +  ward&.name.to_s + " " + district&.name.to_s + " " + province&.name.to_s
  end

  def ext_current_address
    current_address.to_s + " " + ward&.name.to_s + " " + district&.name.to_s + " " + province&.name.to_s
  end

  def destroy_address
    info_injection_book.addresses.destroy_all
  end
end
