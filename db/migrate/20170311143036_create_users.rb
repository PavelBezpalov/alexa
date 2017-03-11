class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :amazon_id
      t.string :username
      t.integer :tax_group

      t.timestamps
    end
    add_index :users, :amazon_id
  end
end
