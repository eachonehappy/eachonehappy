class Post < ApplicationRecord
	acts_as_likeable
	mount_uploader :image, ImageUploader
	has_many :comments
	belongs_to :user


	validates :subject,  presence: true
  validates :description,  presence: true
end
