class CreateFavoritedHirers < ActiveRecord::Migration[6.1]
  def change
    create_table :favorited_hirers do |t|
      t.references :hirer, null: false, foreign_key: true
      t.references :worker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
