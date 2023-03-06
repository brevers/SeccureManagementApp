class Task < ApplicationRecord
  belongs_to :project

  enum :status, %i(ready active concluded)
  enum :department, %i(admin manager engineer qa)

  scope :accessible_to, -> (user) {
    if user.admin?
      all
    else
      where('department = ?', User.roles[user.role])
    end
  }
end
