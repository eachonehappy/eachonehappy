class Comment < ApplicationRecord
	validates :description,  presence: true
end
