class Team < ApplicationRecord
  has_many :user_team
  has_many :users, through: :user_team, source: :user
  belongs_to :user
  has_many :team_comments

  def teamed?(user)
    UserTeam.find_by(user_id: user.id, team_id: id).present?
  end
end
