class CreateTeamTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :team_tasks do |t|
      t.string :team_id
      t.string :task_id

      t.timestamps
    end
  end
end
