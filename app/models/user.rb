class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_friendship
  has_many :organizations, through: :organization_users
  has_many :organization_users
  has_many :campaigns, through: :campaign_users
  has_many :campaign_users
  has_many :jobs, through: :job_users
  has_many :job_users
  has_many :posts
  has_many :comments
  has_many :fundraises
  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
  #has_many :friendships
  #has_many :friends, :through => :friendships

  #has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  #has_many :inverse_friends, :through => :inverse_friendships, :source => :user


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def name
    email.split('@')[0]
  end       
end
