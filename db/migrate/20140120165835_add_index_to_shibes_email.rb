class AddIndexToShibesEmail < ActiveRecord::Migration
  def change
  	add_index :shibes, :email, unique: true
  end
end
