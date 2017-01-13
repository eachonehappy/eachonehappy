class FundraisePaymentDetail < ApplicationRecord
  belongs_to :fundraise
  validates :full_name,  presence: true
  validates :account_number,  presence: true
  validates :ifsc_code,  presence: true
end
