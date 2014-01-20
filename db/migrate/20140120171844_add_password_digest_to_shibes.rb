class AddPasswordDigestToShibes < ActiveRecord::Migration
  def change
    add_column :shibes, :password_digest, :string
  end
end
