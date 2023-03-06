class Task < ApplicationRecord
  belongs_to :project

  enum :status, %i(ready active concluded)
  enum :department, %i(admin manager engineer qa)
end
