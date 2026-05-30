class Group < ApplicationRecord
 has_many :group_users, dependent: :destroy
 has_many :users, through: :group_users

 validates :name, presence: true
 validates :introduction, length:{ maximum: 50}
 validates :owner_id, presence: true

 has_one_attached :group_image

 def get_group_image
  if group_image.attached?
   group_image
  else
   "default-image.jpg"
  end
 end
 
 def joined_by?(user)
  group_users.exist?(user_id: user.id)
 end
 
end
