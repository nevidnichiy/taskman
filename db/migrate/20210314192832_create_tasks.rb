class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.datetime :due_date
      t.integer :position, default: 0
      t.boolean :completed, default: false
      t.timestamps
    end
  end
end
