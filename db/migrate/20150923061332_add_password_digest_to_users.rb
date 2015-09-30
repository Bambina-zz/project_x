class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    ##TODO: Switch the DB to psql, then move NOT NULL constranit into add_column. See #16.
    change_column_null :users, :password_digest, false
  end
end
