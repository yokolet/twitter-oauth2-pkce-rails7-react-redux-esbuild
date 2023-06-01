class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.integer :provider
      t.string :pid

      t.timestamps
    end
  end
end
