class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fullname, :email, :password_digest
      t.string :hometown, :country
      t.timestamps
    end
  end
end
