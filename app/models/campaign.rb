class Campaign < ApplicationRecord
	belongs_to :organization
	belongs_to :cause
  has_many :users, through: :campaign_users
  has_many :campaign_users
  has_many :jobs
  has_many :fundraises
  acts_as_followable
  acts_as_likeable
  acts_as_mentioner

  validates :subject,  presence: true
  validates :description,  presence: true
end
