class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :name
      t.string :address
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
