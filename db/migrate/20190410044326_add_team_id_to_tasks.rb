class AddTeamIdToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :team_id, :string
  end
end
