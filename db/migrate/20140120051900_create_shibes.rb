class CreateShibes < ActiveRecord::Migration
  def change
    create_table :shibes do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
