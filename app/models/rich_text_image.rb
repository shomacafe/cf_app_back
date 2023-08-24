class RichTextImage < ApplicationRecord
  mount_uploader :image, ImageUploader
end
