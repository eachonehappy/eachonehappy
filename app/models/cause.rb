class Cause < ApplicationRecord
 # has_and_belongs_to_many :organizations
  has_many :campaigns


	validates :subject,  presence: true
	validates :description,  presence: true

end
