# frozen_string_literal: true

class ReferralComment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'created_by_id'
  belongs_to :referral
  belongs_to :referral_status
end
