class CreateEmailAttempts < ActiveRecord::Migration[7.2]
  def change
    create_table :email_attempts do |t|
      t.string :subject
      t.text :content
      t.string :recipient
      t.string :status
      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
