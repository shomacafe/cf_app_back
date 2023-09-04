class Return < ApplicationRecord
  belongs_to :project
  has_many :purchases, dependent: :destroy
  mount_uploader :return_image, ImageUploader
end
