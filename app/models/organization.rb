class Organization < ApplicationRecord
  has_many :users, through: :organization_users
  has_many :organization_users
  has_many :campaigns
  has_many :causes, through: :cause_organizations
  has_many :cause_organizations
  acts_as_followable


  validates :name,  presence: true
end
