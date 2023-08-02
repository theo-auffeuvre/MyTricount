class CreateActivity < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :title
      t.string :description
      t.string :currency
      t.string :category

      t.timestamps
    end
  end
end
