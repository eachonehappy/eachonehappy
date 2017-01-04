class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :profile_image, ImageUploader
  mount_uploader :cover_image, ImageUploader
  has_friendship
  has_many :organizations, through: :organization_users
  has_many :organization_users
  has_many :campaigns, through: :campaign_users
  has_many :campaign_users
  has_many :jobs, through: :job_users
  has_many :job_users
  has_many :chat_rooms, through: :chat_room_users
  has_many :chat_room_users
  has_many :posts
  has_many :comments
  has_many :fundraises
  has_many :payments
  has_many :messages, dependent: :destroy
  #has_many :friendships
  #has_many :friends, :through => :friendships

  #has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  #has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  acts_as_liker
  acts_as_follower
  acts_as_followable
  acts_as_mentionable
  validates :first_name,  presence: true
  validates :last_name,  presence: true
  #validates :password, confirmation: true, length: { minimum: 6, maximum: 30 }
  #validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: true, 
             format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include PublicActivity::Model
  tracked
  scope :online, lambda{ where("updated_at > ?", 10.minutes.ago) }
  
  def name
    email.split('@')[0]
  end 

  def online?
    updated_at > 10.minutes.ago
  end  
end
