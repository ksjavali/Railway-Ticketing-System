class AddUsernameToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :username, :string
  end
end
