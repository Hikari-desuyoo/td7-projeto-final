class AddUsernameToHirer < ActiveRecord::Migration[6.1]
  def change
    add_column :hirers, :username, :string
  end
end
