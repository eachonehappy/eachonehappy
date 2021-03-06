class Fundraise < ApplicationRecord
	mount_uploader :image, ImageUploader
  belongs_to :campaign
  belongs_to :user
  has_many :payments
  has_one :fundraise_payment_detail
  has_many :causes, through: :cause_fundraises
  has_many :cause_fundraises
  acts_as_followable
  acts_as_likeable
  acts_as_mentioner



  validates :subject,  presence: true
  validates :target,  presence: true, numericality: { only_integer: true }
  validates :description,  presence: true, length: { minimum: 15 }
  validates :small_description,  presence: true, length: { minimum: 10 }
  include PublicActivity::Model
  tracked
  tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil }
end
