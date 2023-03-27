class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :name
      t.text :description
      t.integer :status
      t.uuid :project_id

      t.timestamps
    end
  end
end
