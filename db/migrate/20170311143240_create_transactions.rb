class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.belongs_to :user, foreign_key: true
      t.float :amount
      t.date :transaction_date

      t.timestamps
    end
  end
end
