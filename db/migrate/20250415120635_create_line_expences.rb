class CreateLineExpences < ActiveRecord::Migration[7.2]
  def change
    create_table :line_expences do |t|
      t.integer :rate
      t.integer :quantity
      t.string :name
      t.references :invoice, foreign_key: true
      t.timestamps
    end
  end
end
