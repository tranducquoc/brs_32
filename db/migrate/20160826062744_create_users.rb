class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :remeber_digest
      t.integer :role, default: 1
      t.string :provider
      t.string :uid

      t.timestamps null: false
    end
  end
end
