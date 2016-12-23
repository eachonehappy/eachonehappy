class Fundraise < ApplicationRecord
	mount_uploader :image, ImageUploader
  belongs_to :campaign
  belongs_to :user
  acts_as_followable
  acts_as_likeable
  acts_as_mentioner



  validates :subject,  presence: true
  validates :target,  presence: true, numericality: { only_integer: true }
end
