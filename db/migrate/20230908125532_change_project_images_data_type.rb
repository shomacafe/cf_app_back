class ChangeProjectImagesDataType < ActiveRecord::Migration[7.0]
  def change
    change_column :projects, :project_images, :json
  end
end
