class AddPasswordDigestToPassengers < ActiveRecord::Migration[6.1]
  def change
    add_column :passengers, :password_digest, :string
    add_column :passengers, :string, :string
  end
end
