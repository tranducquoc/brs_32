class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :cover_image_name
      t.integer :number_of_pages
      t.text :description
      t.datetime :publish_date
      t.integer :price
      t.references :author, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.references :publisher, index: true, foreign_key: true
      t.references :language, index: true, foreign_key: true
      t.boolean :is_in_library, default: false
      t.float :average_rating

      t.timestamps null: false
    end
  end
end
