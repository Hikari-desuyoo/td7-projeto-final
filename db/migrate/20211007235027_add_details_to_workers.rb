class AddDetailsToWorkers < ActiveRecord::Migration[6.1]
  def change
    add_column :workers, :name, :string
    add_column :workers, :surname, :string
    add_column :workers, :social_name, :string
    add_column :workers, :birth_date, :date
    add_column :workers, :education, :text
    add_column :workers, :description, :text
    add_column :workers, :experience, :text
  end
end
