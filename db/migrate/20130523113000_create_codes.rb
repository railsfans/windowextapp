class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.integer :parent_id
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
