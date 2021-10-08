class AddOccupationToWorker < ActiveRecord::Migration[6.1]
  def change
    add_reference :workers, :occupation, null: true, foreign_key: true
  end
end
