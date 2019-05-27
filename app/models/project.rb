class Project < ApplicationRecord
  include FriendlyId
  friendly_id :name, :use => :slugged
  has_many :members, dependent: :destroy
  has_many :users, through: :members, source: :user, dependent: :delete_all
  has_many :tasks
  has_many :comments, class_name: 'Comment::Project', as: :commentable, dependent: :destroy
  belongs_to :user, foreign_key: 'created_by'
  validates :name, length: { in: 1..15 }
  validates :description, length: { in: 1..50 }
  validates :name, uniqueness: true

  def teamed?(user)
    Member.find_by(user_id: user.id, project_id: id).present?
  end
  def normalize_friendly_id(string)
    string.gsub(/[\.\s]/, "-")
  end
  def should_generate_new_friendly_id?
    name_changed? || super
  end
  def self.search(search)
    return nil unless search
    Project.where(['name LIKE ?', "%#{search}%"])
  end
end
