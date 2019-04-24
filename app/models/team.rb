class Team < ApplicationRecord
  has_many :user_team, :dependent => :destroy
  has_many :users, through: :user_team, source: :user
  belongs_to :user
  has_many :team_comments, :dependent => :destroy

  def teamed?(user)
    UserTeam.find_by(user_id: user.id, team_id: id).present?
  end

  def self.search(search)
      return Team.all unless search
      Team.where(['name LIKE ?', "%#{search}%"])
  end
end
