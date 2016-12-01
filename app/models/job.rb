class Job < ApplicationRecord
	belongs_to :campaign


	validates :subject,  presence: true
  validates :description,  presence: true
end
