class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    change_column_null :users, :password_digest, false
  end
end
