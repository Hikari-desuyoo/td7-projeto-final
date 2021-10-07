class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.text :skills_needed
      t.decimal :max_pay_per_hour
      t.date :open_until
      t.boolean :remote
      t.boolean :presential

      t.timestamps
    end
  end
end
