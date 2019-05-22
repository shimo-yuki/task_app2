class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  #自分が作ったタスク
  has_many :tasks, :dependent => :destroy
  #自分が作ったプロジェクト
  has_many :myprojects, class_name: 'Project', :dependent => :destroy
  #自分が所属しているプロジェクト
  has_many :members, :dependent => :destroy
  has_many :projects, through: :members, source: :project, :dependent => :destroy
  #タスクの保存
  has_many :favorites, :dependent => :destroy
  #コメント
  has_many :comments, :dependent => :destroy
  has_many :team_comments, :dependent => :destroy
  validates :name, length: { in: 1..10 }

  def self.search(search)
    return nil unless search
    User.where(['name LIKE ?', "%#{search}%"])
  end
end
