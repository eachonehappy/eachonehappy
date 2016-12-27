class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :post
  acts_as_mentioner


	validates :description,  presence: true
	include PublicActivity::Model
  tracked
  tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil }
end
