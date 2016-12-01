class Job < ApplicationRecord
	belongs_to :campaign
    has_many :users, through: :job_users
    has_many :job_users

	validates :subject,  presence: true
  validates :description,  presence: true
end
