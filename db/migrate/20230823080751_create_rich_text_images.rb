class CreateRichTextImages < ActiveRecord::Migration[7.0]
  def change
    create_table :rich_text_images do |t|
      t.string :image

      t.timestamps
    end
  end
end
