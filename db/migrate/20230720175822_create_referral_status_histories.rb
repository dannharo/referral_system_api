class CreateReferralStatusHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :referral_status_histories do |t|
      t.references :referral, null: false, foreign_key: true
      t.references :referral_status, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
