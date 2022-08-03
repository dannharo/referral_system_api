class Referral < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'referred_by'

  validates :linkedin_url,
            uniqueness: {
              case_sensitive: false,
              message: 'The linkedin profile is already taken'
            },
            format: {
              with: /\A#{URI::regexp}\z/,
              message: 'Invalid LinkedIn URL'
            }
  validates :email,
            uniqueness: {
              case_sensitive: false,
              message: 'The email is already taken'
            },
            format: {
              with: URI::MailTo::EMAIL_REGEXP,
              message: "Invalid e-mail address"
            },
            presence: true,
            length: { minimum: 4, maximum: 254 }
  validates :phone_number, uniqueness: { message: 'The phone number is already taken' }
end
