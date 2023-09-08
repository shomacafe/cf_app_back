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

  validates :name, presence: true, length: { maximum: 12, message: '名前は12文字以内で入力してください。' }
  validate :profile_length
  validates :password, length: { in: 6..15, message: 'パスワードは6文字以上15文字以内で入力してください。' }, allow_blank: true
  validates :password_confirmation, presence: true, if: :password_changed?
  validate :password_confirmation_match, if: :password_confirmation

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザー'
      user.profile = 'ゲストユーザーです。よろしくお願いします。'
    end
  end

  private

  def profile_length
    if profile
      profile_for_validation = profile.gsub(/\r\n/,"")
      if profile_for_validation.length > 100
        errors.add(:profile, "プロフィールは100文字以内で入力してください。")
      end
    end
  end

  def password_changed?
    password.present? || password_confirmation.present?
  end

  def password_confirmation_match
    unless password == password_confirmation
      errors.add(:password_confirmation, "パスワードと確認用パスワードが一致しません")
    end
  end
end
