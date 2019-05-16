class Project < ApplicationRecord
    has_many :members, :dependent => :destroy
    has_many :users, through: :members, source: :user,  :dependent => :delete_all
    belongs_to :user, foreign_key: 'created_by'
    has_many :team_comments, :dependent => :destroy


    def teamed?(user)
      Member.find_by(user_id: user.id, project_id: id).present?
    end
  
    def self.search(search)
        return nil unless search
        Project.where(['name LIKE ?', "%#{search}%"])
    end
end
