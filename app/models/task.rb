class Task < ApplicationRecord
  belongs_to :project

  enum :status, %i(ready active concluded)
end
