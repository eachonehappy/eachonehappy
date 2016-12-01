class Cause < ApplicationRecord
  has_many :organizations, through: :cause_organizations
  has_many :cause_organizations
  has_many :campaigns


	validates :subject,  presence: true
	validates :description,  presence: true

end
