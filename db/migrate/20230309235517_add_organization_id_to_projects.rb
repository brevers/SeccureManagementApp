class AddOrganizationIdToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :organization_id, :integer
  end
end
