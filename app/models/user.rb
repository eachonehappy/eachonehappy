class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_and_belongs_to_many :organizations
  has_and_belongs_to_many :causes
  #has_many :posts
  has_many :comments
  has_many :fundraises

  has_many :friends, class_name: "User"
  has_many :followers, class_name: "User"


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
