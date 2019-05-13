class CreateAssigns < ActiveRecord::Migration[5.2]
  def change
    create_table :assigns do |t|
      t.string :user_id
      t.string :task_id

      t.timestamps
    end
  end
end
