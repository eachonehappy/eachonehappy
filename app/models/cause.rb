class Cause < ApplicationRecord
	mount_uploader :image, ImageUploader
  has_many :organizations, through: :cause_organizations
  has_many :cause_organizations
  has_many :campaigns
  acts_as_followable
  acts_as_likeable
	validates :subject,  presence: true
	validates :description,  presence: true
	include PublicActivity::Model
  tracked
  tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil }

end
