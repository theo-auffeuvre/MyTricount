class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.string :title
      t.float :amount
      t.date :date
      t.references :participant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
