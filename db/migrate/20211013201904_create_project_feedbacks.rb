class CreateProjectFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :project_feedbacks do |t|
      t.references :project, null: false, foreign_key: true
      t.references :worker, null: false, foreign_key: true
      t.text :comment
      t.integer :score

      t.timestamps
    end
  end
end
