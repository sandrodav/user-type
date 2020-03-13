class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :fname,              null: false
      t.string :lname,              null: false
      t.string :email,              null: false
      t.string :username,              null: false
      t.date :birthday,              null: false
      t.boolean :active, default: false
      t.references :type,  references: :user_types, foreign_key: {to_table: :user_types}


      t.string   :crypted_password, limit: 255
      t.string   :salt, limit: 255

      t.timestamps
    end
  end
end
