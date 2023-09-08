# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :projects, dependent: :destroy
  has_many :purchases, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  mount_uploader :user_image, ImageUploader

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザー'
      user.profile = 'ゲストユーザーです。よろしくお願いします。'
    end
  end
end
