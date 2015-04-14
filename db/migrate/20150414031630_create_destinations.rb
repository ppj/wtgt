class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :category
      t.boolean :visited
      t.integer :place_id, :user_id
      t.timestamps
    end
  end
end
