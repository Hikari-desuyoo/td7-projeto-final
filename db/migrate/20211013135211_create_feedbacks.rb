class CreateFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks do |t|
      t.references :hirer, null: false, foreign_key: true
      t.references :worker, null: false, foreign_key: true
      t.text :comment
      t.integer :score

      t.timestamps
    end
  end
end
