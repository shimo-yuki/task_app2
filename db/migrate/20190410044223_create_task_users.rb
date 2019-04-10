class CreateTaskUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :task_users do |t|
      t.string :task_id
      t.string :user_id

      t.timestamps
    end
  end
end
