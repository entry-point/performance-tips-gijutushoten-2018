class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.integer :age, null: false
      t.string :sex, null: false
      t.string :email, null: false

      t.index :name
      t.index :email
      t.timestamps
    end
  end
end
