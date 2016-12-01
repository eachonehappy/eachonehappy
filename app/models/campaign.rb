class Campaign < ApplicationRecord
	belongs_to :organization
	belongs_to :cause
  has_and_belongs_to_many :users
  has_many :jobs
  has_many :fundraises


  validates :subject,  presence: true
  validates :description,  presence: true
end
