class Task < ApplicationRecord
  belongs_to :user
  validates :title, :content, :deadline, :status, presence: true

  def display_status
    if status == 0
      "未対応"
    elsif status == 1
      "対応中"
    else
      "完了"
    end
  end

  def expired?
    deadline > Time.now
  end

end
