class CreateReferralStatus < ActiveRecord::Migration[7.0]
  def change
    create_table :referral_statuses do |t|
      t.string :status
      t.text :description

      t.timestamps
    end
    statuses = %w[Recruitment Interviewing Managers Client Offer Hiring Failed]

    statuses.each_with_index do |status, index|
      ReferralStatus.create(id: index + 1, status: status)
    end
  end
end
