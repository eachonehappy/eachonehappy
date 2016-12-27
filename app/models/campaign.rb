class Campaign < ApplicationRecord
  mount_uploader :image, ImageUploader
	belongs_to :organization
	belongs_to :cause
  has_many :users, through: :campaign_users
  has_many :campaign_users
  has_many :jobs
  has_many :fundraises
  acts_as_followable
  acts_as_likeable
  acts_as_mentioner

  validates :subject,  presence: true
  validates :description,  presence: true
  include PublicActivity::Model
  tracked
  tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil }
end
