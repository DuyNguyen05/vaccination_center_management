class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable

  belongs_to :role
  belongs_to :details_info, optional: true
  belongs_to :vaccine, optional: true

end
