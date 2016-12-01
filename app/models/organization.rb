class Organization < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :campaigns
  has_and_belongs_to_many :causes


  validates :name,  presence: true
end
