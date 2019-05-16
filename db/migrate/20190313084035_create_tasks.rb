class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :content
      t.datetime :deadline
      t.integer :user_id
      t.integer :status
      t.integer :team_id

      t.timestamps
    end
  end
end
