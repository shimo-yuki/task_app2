class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :user_id
      t.string :teema

      t.timestamps
    end
  end
end