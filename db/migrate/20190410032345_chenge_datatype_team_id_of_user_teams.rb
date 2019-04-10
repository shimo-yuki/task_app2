class ChengeDatatypeTeamIdOfUserTeams < ActiveRecord::Migration[5.2]
  def change
    change_column :user_teams, :team_id, :string
  end
end
