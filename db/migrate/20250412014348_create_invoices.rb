class CreateInvoices < ActiveRecord::Migration[7.2]
  def change
    create_table :invoices do |t|
      t.text :details
      t.text :from
      t.text :to
      t.date :date
      t.date :due_date
      t.bigint :total
      t.string :name

      t.timestamps
    end
  end
end
