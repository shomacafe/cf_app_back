class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.references :return, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.integer :quantity, null: false, comment: "リターンの購入数"
      t.integer :amount, null: false, comment: "リターンの購入額"

      t.timestamps
    end
  end
end
