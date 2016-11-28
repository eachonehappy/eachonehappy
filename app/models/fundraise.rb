class Fundraise < ApplicationRecord
  validates :subject,  presence: true
  validates :target,  presence: true, numericality: { only_integer: true }
end
