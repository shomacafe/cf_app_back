class Project < ApplicationRecord
  belongs_to :user
  has_many :returns, dependent: :destroy
  has_many :purchases, dependent: :destroy
  accepts_nested_attributes_for :returns, allow_destroy: true
  mount_uploaders :project_images, ImageUploader

  validate :end_date_must_be_after_start_date

  validates :title, presence: true, length: { maximum: 30 }
  validates :goal_amount, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  def end_date_must_be_after_start_date
    if start_date.present? && end_date.present? && end_date <= start_date
      errors.add(:end_date, "終了日は開始日より後の日付を選択してください")
    end
  end
end
