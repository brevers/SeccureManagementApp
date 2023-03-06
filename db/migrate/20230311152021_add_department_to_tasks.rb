class AddDepartmentToTasks < ActiveRecord::Migration[7.0]
  def change
    # Department is bounded to user's roles
    add_column :tasks, :department, :integer
  end
end
