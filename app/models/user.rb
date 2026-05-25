class User < ApplicationRecord
  has_secure_password
  has_one_attached :profile_image
  has_many :sessions, dependent: :destroy
  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :name,
            presence: true,
            uniqueness: true,
            length: { in: 2..20 }

  validates :introduction,
            length: { maximum: 50 }
end
