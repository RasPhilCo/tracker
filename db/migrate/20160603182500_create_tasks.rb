class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks, id: :uuid do |t|
      t.uuid :project_id, foreign_key: true
      t.index :project_id
      t.string :name
      t.string :description
      t.integer :state, default: 1

      t.timestamps null: false
    end
  end
end
