class CreateTeamComments < ActiveRecord::Migration[5.2]
  def change
    create_table :team_comments do |t|
      t.string :team_id
      t.string :user_id
      t.string :comment

      t.timestamps
    end
  end
end
