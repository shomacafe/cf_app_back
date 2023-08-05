class CreateReturns < ActiveRecord::Migration[7.0]
  def change
    create_table :returns do |t|
      t.references :project, foreign_key: true, null: false
      t.string :name, null: false, comment: "リターン名"
      t.integer :price, null: false, comment: "リターンの価格"
      t.string :return_image, null: false, comment: "リターン画像"
      t.text :description, null: false, comment: "リターンの説明"
      t.integer :stock_count, null: false, default: false, comment: "リターンの在庫数"

      t.timestamps
    end
  end
end
