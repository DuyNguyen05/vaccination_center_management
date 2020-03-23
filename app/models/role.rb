class Role < ApplicationRecord
  enum role: {admin: 1, super_admin: 2, user: 3 , staff: 4}
end
