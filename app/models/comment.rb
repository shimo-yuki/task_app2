class Comment < ApplicationRecord
  belongs_to :user
  # has_many :tasks
  # has_many :projects
  validates :content, length: { in: 1..50 }
  self.inheritance_column = :_type_disabled 
end
