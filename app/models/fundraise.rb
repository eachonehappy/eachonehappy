class Fundraise < ApplicationRecord
  belongs_to :cause
  belongs_to :user



  validates :subject,  presence: true
  validates :target,  presence: true, numericality: { only_integer: true }
end
