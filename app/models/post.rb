class Post < ApplicationRecord
	has_many :comments
	belongs_to :user


	validates :subject,  presence: true
  validates :description,  presence: true
end
