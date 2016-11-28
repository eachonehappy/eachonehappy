class Cause < ApplicationRecord
  validates :subject,  presence: true
  validates :description,  presence: true
end
