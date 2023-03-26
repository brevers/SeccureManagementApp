class Task < ApplicationRecord
  belongs_to :project

  before_validation :set_defaults

  enum :status, %i(ready active concluded)
  enum :department, %i(admin manager engineer qa)

  scope :accessible_to, -> (user) {
    if user.manager_or_above?
      all
    else
      where('department = ?', User.roles[user.role])
    end
  }

  private

  def set_defaults
    self.department = User.roles[:admin] unless self.department.present?
  end
end
