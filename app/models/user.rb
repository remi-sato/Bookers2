class User < ApplicationRecord
  has_secure_password
  has_one_attached :profile_image

  has_many :sessions, dependent: :destroy
  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :relationships,
           class_name: "Relationship",
           foreign_key: "follower_id",
           dependent: :destroy

  has_many :reverse_of_relationships,
           class_name: "Relationship",
           foreign_key: "followed_id",
           dependent: :destroy

  has_many :followings,
           through: :relationships,
           source: :followed

  has_many :followers,
           through: :reverse_of_relationships,
           source: :follower

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :name,
            presence: true,
            uniqueness: true,
            length: { in: 2..20 }

  validates :introduction,
            length: { maximum: 50 }

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      User.where("name LIKE ?", word)
    elsif search == "forward_match"
      User.where("name LIKE ?", "#{word}%")
    elsif search == "backward_match"
      User.where("name LIKE ?", "%#{word}")
    elsif search == "partial_match"
      User.where("name LIKE ?", "%#{word}%")
    else
      User.all
    end
  end

  def joined?(group)
   groups.exists?(group.id)
  end
end