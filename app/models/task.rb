class Task < ApplicationRecord
  has_many :favorites, :dependent => :destroy
  belongs_to :user
  # has_many :comments, :dependent => :destroy

  validates :deadline, :status, presence: true
  validates :title, length: { in: 1..10 } 
  validates :content, length: { in: 1..50 }

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
    where(status: [1, 2])
  }

end
