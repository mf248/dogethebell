class AddRememberTokenToShibes < ActiveRecord::Migration
  def change
  	add_column :shibes, :remember_token, :string
    add_index  :shibes, :remember_token
  end
end
