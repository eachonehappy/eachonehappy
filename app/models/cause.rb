class Cause < ApplicationRecord
  belongs_to :organization
  has_and_belongs_to_many :users
  has_many :jobs
  has_many :fundraises


  validates :subject,  presence: true
  validates :description,  presence: true
end
