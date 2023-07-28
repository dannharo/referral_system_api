# frozen_string_literal: true

class ReferralStatus < ApplicationRecord
  has_many :referrals
end
