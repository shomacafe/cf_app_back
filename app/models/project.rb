class Project < ApplicationRecord
  belongs_to :user
  has_many :returns, dependent: :destroy
  accepts_nested_attributes_for :returns, allow_destroy: true
end
