class AddUniqueConstraintOnUserColumns < ActiveRecord::Migration[6.1]
  def change
    add_index :users, [:first_name, :last_name, :phone_number], :unique => true
  end
end
