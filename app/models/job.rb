class Job < ApplicationRecord
	belongs_to :campaign
  has_many :users, through: :job_users
  has_many :job_users

	validates :subject,  presence: true
  validates :description,  presence: true
  acts_as_mentioner
  include PublicActivity::Model
  tracked
  tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil }
end
