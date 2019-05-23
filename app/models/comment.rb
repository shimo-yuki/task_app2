class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  # has_many :projects
  validates :content, length: { in: 1..50 }
end
