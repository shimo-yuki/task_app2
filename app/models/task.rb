class Task < ApplicationRecord
  has_many :favorites
  has_many :task_users
  has_many :users, through: :task_users
  belongs_to :user
  has_many :team_tasks
  has_many :teams, through: :team_tasks, source: :team

  validates :title, :content, :deadline, :status, presence: true

  def display_status
    case status
    when 1
      "未対応"
    when 2
      "対応中"
    when 3
      "完了"
    end
  end

  def expired?
    deadline > Time.now
  end

  def current_user?(user)
    user.id == user_id
  end

  def favorite_by?(user)
    Favorite.find_by(user_id: user.id, task_id: id)
  end

  scope :visible, -> {
    where(status: [0, 1])
  }

end
