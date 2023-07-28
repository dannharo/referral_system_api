class RenameReferralsColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column(:referrals, :status, :referral_status_id)
  end
end
