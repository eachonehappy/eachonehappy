class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :post
  acts_as_mentioner


	validates :description,  presence: true
end
