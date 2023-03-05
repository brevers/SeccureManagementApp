class Task < ApplicationRecord
  belongs_to :project

  validates :status, inclusion: {in: ["not-started-yet", "on-going", "concluded" ]}

  STATUS_PREFERENCES = [
    ["TO BE DONE", "not-started-yet"],
    ["ONGOING", "on-going"],
    ["DONE", "not-started-yet"]
  ]
end
