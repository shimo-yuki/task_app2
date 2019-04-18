class ChangeDatatypeTeamIdOfTasks < ActiveRecord::Migration[5.2]
  def change
      change_column :tasks, :team_id, :string
  end
end
