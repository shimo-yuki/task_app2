class Task < ApplicationRecord
  belongs_to :user
  validates :title, :content, :deadline, :status, presence: true

  def display_status
    case status
    when 0
      "未対応"
    when 1
      "対応中"
    when 2
      "完了"
    end
  end

  def expired?
    deadline > Time.now
  end

  scope :visible, -> {
    where(status: [0, 1])
  }

end
