class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
    	t.integer :from_id
    	t.string :from_type
    	t.integer :to_id
    	t.string :to_type
    	t.integer	:amount
      t.timestamps
    end

    add_index :transactions, [:from_id, :from_type]
    add_index :transactions, [:to_id, :to_type]

  end
end
