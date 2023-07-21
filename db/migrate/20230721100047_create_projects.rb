class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.references :user, foreign_key: true, null: false
      t.string :title, null: false, comment: 'プロジェクトタイトル'
      t.string :catch_copies, null: false, comment: 'キャッチコピー'
      t.integer :goal_amount, null: false, comment: '目標金額'
      t.datetime :start_date, null: false, comment: '開始日'
      t.datetime :end_date, null: false, comment: '終了日'
      t.text :project_images, null: false, comment: 'プロジェクト画像 '
      t.text :description, null: false, comment: 'プロジェクト説明'
      t.boolean :is_published, null: false, default: false, comment: '公開/非公開のフラグ'

      t.timestamps
    end
  end
end
