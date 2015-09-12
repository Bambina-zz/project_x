class CreateErrands < ActiveRecord::Migration
  def change
    create_table :errands do |t|
      t.string :name, null: false
      t.string :shared_hash, null: false
      t.integer :owner_id, null: false

      t.timestamps null: false
    end
    add_index :errands, :shared_hash, unique: true
  end
end
