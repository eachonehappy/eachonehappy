class OrganizationUser < ApplicationRecord
	belongs_to :organization
	belongs_to :user
	scope :send_by_user, -> { where(status: 'send_by_user') }
	scope :send_by_owner, -> { where(status: 'send_by_owner') }
	scope :accepted, -> { where(status: 'accepted') }
end
