class Job < ApplicationRecord
	belongs_to :cause



	validates :subject,  presence: true
  validates :description,  presence: true
end
