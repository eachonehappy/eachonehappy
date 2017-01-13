class Post < ApplicationRecord
	include PublicActivity::Model
    tracked
	acts_as_likeable
	acts_as_mentioner
	mount_uploader :image, ImageUploader
	has_many :comments
	belongs_to :user

    
  tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil }
end
