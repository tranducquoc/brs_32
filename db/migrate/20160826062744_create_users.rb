class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :remeber_digest
      t.integer :role, default: 1

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
