class Organization < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :causes
  has_and_belongs_to_many :categories


  validates :name,  presence: true
end
