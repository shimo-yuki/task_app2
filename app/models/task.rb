class Task < ApplicationRecord
  belongs_to :user

  def finish_task(status)
    if status == 0
      return "未対応"
    elsif status == 1
      return "対応中"
    else
      return "完了"
    end
  end

  def date_task(deadline)
    if Date.parse(deadline.to_s) <= Date.today
      return "out"
    end
  end
end
