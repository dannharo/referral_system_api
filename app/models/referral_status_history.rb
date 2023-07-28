# frozen_string_literal: true

class ReferralStatusHistory < ApplicationRecord
  belongs_to :referral
  belongs_to :referral_status
end
