class Campaign < ApplicationRecord
	belongs_to :organization
	belongs_to :cause
  has_many :users, through: :campaign_causes
  has_many :campaign_causes
  has_many :jobs
  has_many :fundraises


  validates :subject,  presence: true
  validates :description,  presence: true
end
