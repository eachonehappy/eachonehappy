class Cause < ApplicationRecord
	mount_uploader :image, ImageUploader
  has_many :organizations, through: :cause_organizations
  has_many :cause_organizations
  has_many :campaigns
  belongs_to :user
  has_many :fundraises, through: :cause_fundraises
  has_many :cause_fundraises
  acts_as_followable
  acts_as_likeable
	validates :subject,  presence: true
	validates :description,  presence: true, length: { minimum: 15 }
  validates :small_description,  presence: true, length: { minimum: 10 }
end
