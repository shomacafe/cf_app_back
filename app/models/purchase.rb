class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :return
end
