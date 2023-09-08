class Return < ApplicationRecord
  belongs_to :project
  has_many :purchases, dependent: :destroy
  mount_uploader :return_image, ImageUploader

  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
end
