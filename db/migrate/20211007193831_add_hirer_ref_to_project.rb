class AddHirerRefToProject < ActiveRecord::Migration[6.1]
  def change
    add_reference :projects, :hirer, null: false, foreign_key: true
  end
end
