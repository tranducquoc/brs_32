class CreateUserBooks < ActiveRecord::Migration
  def change
    create_table :user_books do |t|
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      t.integer :status
      t.boolean :is_favorite, default: false
      t.float :rating
      t.text :review

      t.timestamps null: false
    end
  end
end
