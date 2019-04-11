class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  #自分が属しているタスク
  has_many :mytsasks, class_name: 'Task'
  has_many :taskusers, through: :assigns, source: :task
  #自分が作ったタスク
  has_many :tasks
  #自分が作ったチーム
  has_many :myteams, class_name: 'Team'
  #自分が所属しているチーム
  has_many :user_teams
  has_many :teams, through: :user_teams, source: :team

  #タスクの保存
  has_many :favorites

  def self.search(search)
      return User.all unless search
      User.where(['name LIKE ?', "%#{search}%"])
  end
end
