class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :address
      t.string :title
      t.integer :shibe_id

      t.timestamps
    end
    add_index :links, [:shibe_id, :created_at]
  end
end
