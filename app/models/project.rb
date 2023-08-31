class Project < ApplicationRecord
  belongs_to :user
  has_many :returns, dependent: :destroy
  has_many :purchases, dependent: :destroy
  accepts_nested_attributes_for :returns, allow_destroy: true
  mount_uploaders :project_images, ImageUploader
end
