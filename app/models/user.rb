class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :organizations, through: :organization_users
  has_many :organization_users
  has_many :campaigns, through: :campaign_users
  has_many :campaign_users
  has_many :posts
  has_many :comments
  has_many :fundraises

  has_many :friends, class_name: "User"
  has_many :followers, class_name: "User"


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
