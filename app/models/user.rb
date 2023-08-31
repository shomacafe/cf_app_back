# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :projects, dependent: :destroy
  has_many :purchases, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
end
