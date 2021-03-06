class Organization < ApplicationRecord
  has_many :users, through: :organization_users
  has_many :organization_users
  has_many :campaigns
  has_many :causes, through: :cause_organizations
  has_many :cause_organizations
  mount_uploader :profile_image, ImageUploader
  mount_uploader :cover_image, ImageUploader
  acts_as_followable
  acts_as_likeable

  validates :name,  presence: true
  validates :description,  presence: true, length: { minimum: 10 }
end
