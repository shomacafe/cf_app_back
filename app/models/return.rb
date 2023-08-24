class Return < ApplicationRecord
  belongs_to :project
  mount_uploader :return_image, ImageUploader
end
