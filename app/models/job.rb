class Job < ApplicationRecord
	validates :subject,  presence: true
  validates :description,  presence: true
end
