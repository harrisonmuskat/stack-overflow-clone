class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :username, null: false

      t.timestamps null: false
    end
  end
end
